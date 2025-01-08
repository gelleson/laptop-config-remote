#!/bin/bash

# Script to install LLM plugins using the llm command.
#
# Author: galleson
#
# This script checks if the 'llm' command is installed on the system.
# If it is not installed, the script exits with a message.
# It proceeds to install a predefined list of LLM plugins.
# Errors during installation are ignored, and no error messages are displayed.

# Check if the llm command is installed
if ! command -v llm &> /dev/null
then
    echo "llm command not found. Please install it first."
    exit 1
fi

# Array of LLM plugins to install
plugins=(llm-together llm-groq llm-gemini llm-claude-3 llm-ollama llm-openrouter)

# Install the LLM plugins
echo "Installing LLM plugins..."

for plugin in "${plugins[@]}"; do
    llm install "$plugin" &> /dev/null
    echo "$plugin installation attempt completed."
done

echo "Plugin installation process completed."
