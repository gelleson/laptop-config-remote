#!/usr/bin/env uv run -q
# /// script
# dependencies = [
#   "requests<3",
#   "typer",
# ]
# ///
import os
import json
import sys
import urllib.request
import typer
import fnmatch
from pathlib import Path

app = typer.Typer()

alias_ = typer.Typer()

# Paths to configuration files
config_path = Path("~/.config/llm-price/models.json").expanduser()
alias_path = Path("~/.config/llm-price/alias.json").expanduser()


# Check if the JSON configuration files exist and download or create if not
def ensure_config():
    if not config_path.exists():
        typer.echo("Configuration file not found. Downloading...")
        os.makedirs(config_path.parent, exist_ok=True)
        url = "https://raw.githubusercontent.com/BerriAI/litellm/refs/heads/main/litellm/model_prices_and_context_window_backup.json"  # Replace with the actual URL
        urllib.request.urlretrieve(url, config_path)

    # Ensure alias file exists
    if not alias_path.exists():
        typer.echo("Alias file not found. Creating an empty alias file.")
        with open(alias_path, "w") as file:
            json.dump({}, file)  # Create an empty alias file


# Load the JSON configuration data
def load_config():
    with open(config_path, "r") as file:
        return json.load(file)


# Load the alias data
def load_aliases():
    with open(alias_path, "r") as file:
        return json.load(file)


# Save the alias data to the alias file
def save_aliases(aliases):
    with open(alias_path, "w") as file:
        json.dump(aliases, file, indent=2)


# Function to resolve model aliases
def resolve_alias(model_name: str, aliases: dict):
    return aliases.get(model_name, model_name)


# Function to calculate the total cost and format the output
def calculate_total_cost(data, model: str, input_tokens: int, output_tokens: int, multiplier: float, format: str):
    preset = data.get(model)
    if not preset:
        typer.echo(f"Model {model} not found.")
        sys.exit(1)

    input_cost = input_tokens * preset["input_cost_per_token"]
    output_cost = output_tokens * preset["output_cost_per_token"]
    total_cost = (input_cost + output_cost) * multiplier

    # Use match for formatting based on the user preference
    match format:
        case "plain":
            typer.echo(f"Total Cost: ${total_cost:.5f}")
        case "simple":
            typer.echo(f"{total_cost:.5f}")
        case "json":
            typer.echo(json.dumps({"model": model, "total_cost": total_cost}, indent=2))
        case "detailed":
            typer.echo(
                f"Model: {model}\n"
                f"Input Tokens: {input_tokens}\n"
                f"Output Tokens: {output_tokens}\n"
                f"Multiplier: {multiplier}\n"
                f"Input Cost: ${input_cost:.5f}\n"
                f"Output Cost: ${output_cost:.5f}\n"
                f"Total Cost: ${total_cost:.5f}"
            )
        case _:
            typer.echo(f"Unknown format: {format}. Please choose 'plain', 'simple', 'json', or 'detailed'.")


@app.command("calc")
def calc(
        model: str = typer.Option("gpt-4o", "--model", "-m",
                                  help="Model name or alias (e.g., gpt-4, sample_spec, or alias)"),
        input_tokens: int = typer.Option(..., "--input_tokens", "-i", help="Number of input tokens"),
        output_tokens: int = typer.Option(..., "--output_tokens", "-o", help="Number of output tokens"),
        multiplier: float = typer.Option(1.0, "--multiplier", "-x", help="Cost multiplier (default: 1)"),
        format: str = typer.Option("plain", "--format", "-f",
                                   help="Output format: 'plain', 'simple', 'json', or 'detailed'"),
):
    """
    Calculate LLM pricing based on model presets, with support for model aliases.
    """
    # Ensure config files exist, download or create if necessary
    ensure_config()

    # Load the configuration data and aliases
    data = load_config()
    aliases = load_aliases()

    # Resolve alias if one is used
    resolved_model = resolve_alias(model, aliases)

    # Calculate and display the total cost in the specified format
    calculate_total_cost(data, resolved_model, input_tokens, output_tokens, multiplier, format)


@alias_.command("add")
def add_alias(alias: str, model: str):
    """
    Add or update an alias for a model.
    """
    # Ensure config files exist, download or create if necessary
    ensure_config()

    # Load configuration data and aliases
    data = load_config()
    aliases = load_aliases()

    # Check if the model exists in the main configuration
    if model not in data:
        typer.echo(f"Error: Model '{model}' does not exist in the configuration.")
        sys.exit(1)

    # Update or add the alias
    aliases[alias] = model
    save_aliases(aliases)
    typer.echo(f"Alias '{alias}' added for model '{model}'.")


@alias_.command("remove")
def remove_alias(alias: str):
    """
    Remove an alias for a model.
    """
    # Ensure config files exist, download or create if necessary
    ensure_config()

    # Load configuration data and aliases
    data = load_config()
    aliases = load_aliases()

    # Check if the alias exists in the aliases
    if alias not in aliases:
        typer.echo(f"Error: Alias '{alias}' does not exist in the aliases.")
        sys.exit(1)

    # Remove the alias
    del aliases[alias]
    save_aliases(aliases)
    typer.echo(f"Alias '{alias}' removed.")


@alias_.command("list")
def list_aliases():
    """
    List all aliases.
    """
    # Ensure config files exist, download or create if necessary
    ensure_config()

    # Load configuration data and aliases
    data = load_config()
    aliases = load_aliases()

    # Display aliases
    for alias, model in aliases.items():
        typer.echo(f"Alias: {alias}")
        typer.echo(f"  Model: {model}")
        typer.echo("-" * 30)


@app.command("models")
def list_models(
        provider: str = typer.Option(None, "--provider", "-p", help="Filter models by provider"),
        mode: str = typer.Option("chat", "--mode", "-m", help="Filter models by mode (e.g., chat, embedding, etc.)"),
        sort_by: str = typer.Option(None, "--sort-by", "-s",
                                    help="Sort by 'input' or 'output' per million tokens. Prefix with '-' for descending."),
        limit: int = typer.Option(None, "--limit", "-n", help="Limit the number of models displayed"),
        search: str = typer.Option(None, "--search", "-q", help="Search models by name using glob pattern"),
        list_providers: bool = typer.Option(False, "--list-providers", "-l", help="List available providers"),
):
    """
    List models and their input/output costs (per million tokens), optionally filtered by provider, mode, sorted by price, limited, and searchable by model name.
    """
    # Ensure config file exists, download if necessary
    ensure_config()

    # Load the configuration data
    data = load_config()

    # Valid modes
    valid_modes = {"chat", "embedding", "completion", "image_generation", "audio_transcription", "audio_speech"}

    # Validate mode if provided
    if mode and mode not in valid_modes:
        typer.echo(f"Invalid mode: {mode}. Valid options are {', '.join(valid_modes)}.")
        sys.exit(1)

    # Collect providers if listing only providers
    if list_providers:
        providers = {model["litellm_provider"] for model in data.values() if "litellm_provider" in model}
        typer.echo("Available providers:")
        for provider in sorted(providers):
            typer.echo(f"- {provider}")
        return

    # Gather models based on filters
    models = []
    for model_name, model_data in data.items():
        # Filter by provider if specified
        if provider and model_data.get("litellm_provider") != provider:
            continue

        # Filter by mode if specified
        if mode and model_data.get("mode") != mode:
            continue

        # Filter by search pattern if specified
        if search and not fnmatch.fnmatch(model_name.lower(), search.lower()):
            continue

        # Convert input and output cost per token to cost per million tokens
        input_cost_per_million = model_data.get("input_cost_per_token", 0) * 1_000_000
        output_cost_per_million = model_data.get("output_cost_per_token", 0) * 1_000_000

        models.append({
            "name": model_name,
            "provider": model_data.get("litellm_provider", "N/A"),
            "mode": model_data.get("mode", "N/A"),
            "input_cost_per_million": input_cost_per_million,
            "output_cost_per_million": output_cost_per_million,
        })

    # Determine sorting field and order
    descending = False
    if sort_by:
        if sort_by.startswith("-"):
            descending = True
            sort_by = sort_by[1:]  # Remove the "-" prefix for the key name

        if sort_by == "input":
            models.sort(key=lambda x: x["input_cost_per_million"], reverse=descending)
        elif sort_by == "output":
            models.sort(key=lambda x: x["output_cost_per_million"], reverse=descending)
        else:
            typer.echo(f"Invalid sort option: {sort_by}. Choose 'input' or 'output'.")
            sys.exit(1)

            # Limit the number of displayed models if specified
    if limit:
        models = models[:limit]

        # Display models
    for model in models:
        typer.echo(f"Model: {model['name']}")
        typer.echo(f"  Provider: {model['provider']}")
        typer.echo(f"  Mode: {model['mode']}")
        typer.echo(f"  Input Cost per Million Tokens: ${model['input_cost_per_million']:.2f}")
        typer.echo(f"  Output Cost per Million Tokens: ${model['output_cost_per_million']:.2f}")
        typer.echo("-" * 30)

app.add_typer(alias_, name="alias", help="Manage aliases for models.")

if __name__ == "__main__":
    app()
