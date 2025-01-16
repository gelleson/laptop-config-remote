#!/bin/bash

# ------------------------------------------------------------------------------
# Script Name: manage_nix_darwin.sh
# Description: Modular script with subcommands to manage Homebrew, Nix, and
#              nix-darwin installation, configuration, and activation.
#
# Subcommands:
#   install   - Installs Homebrew and Nix.
#   config    - Fetches configuration from GitHub and ensures nix.conf is updated.
#   activate  - Installs nix-darwin (if needed) and activates the configuration.
#
# Options:
#   --help    - Displays usage information for the script.
#
# Usage:
#   SH_ACTION=install ./manage_nix_darwin.sh
#   ./manage_nix_darwin.sh <subcommand>
#
# Requirements:
# - Bash shell
#
# Author: Gelleson
# Date: 2024-10-12
# ------------------------------------------------------------------------------

# Default environment variables (can be overridden by setting them when running the script)
CONFIG_REPO="${CONFIG_REPO:-https://github.com/gelleson/laptop-config-remote}"
CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/nix-darwin}"
NIX_CONF_FILE="${NIX_CONF_FILE:-/etc/nix/nix.conf}"
FLAKE_TARGET="${FLAKE_TARGET:-$HOME/.config/nix-darwin#my-mac}"

# Function to display help/usage information
usage() {
    echo "Usage: $0 {install|config|activate|--help}"
    echo ""
    echo "Subcommands:"
    echo "  install   - Installs Homebrew and Nix."
    echo "  config    - Fetches configuration from GitHub and ensures nix.conf is updated."
    echo "  activate  - Installs nix-darwin (if needed) and activates the configuration."
    echo ""
    echo "Options:"
    echo "  --help    - Displays this help message."
    echo ""
    echo "Environment Variables:"
    echo "  SH_ACTION     - Run the script with a specific action (install, config, activate)."
    echo "  CONFIG_REPO   - URL of the GitHub repository for fetching configuration (default: $CONFIG_REPO)"
    echo "  CONFIG_DIR    - Directory for storing configuration (default: $CONFIG_DIR)"
    echo "  NIX_CONF_FILE - Path to the Nix configuration file (default: $NIX_CONF_FILE)"
    echo "  FLAKE_TARGET  - Target flake for nix-darwin (default: $FLAKE_TARGET)"
    echo ""
    echo "Examples:"
    echo "  SH_ACTION=install $0"
    echo "  CONFIG_REPO=https://github.com/your/repo.git CONFIG_DIR=~/.config/my-config $0 config"
    echo "  $0 install"
    exit 0
}

# Subcommand: install - Installs Homebrew and Nix
install() {
    echo "Starting installation of Homebrew and Nix..."

    # Function to install Homebrew
    install_homebrew() {
        echo "Homebrew is not installed. Installing now..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
        echo "Homebrew installation complete."
    }

    # Function to check if Homebrew is installed
    check_homebrew_installed() {
        if command -v brew &> /dev/null; then
            echo "Homebrew is already installed."
        elif [ -f "/opt/homebrew/bin/brew" ]; then
            echo "Homebrew is installed, but not in PATH. Adding to PATH..."
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            install_homebrew
        fi
    }

    # Function to install Nix
    install_nix() {
        echo "Nix is not installed. Installing now..."
        curl -L https://nixos.org/nix/install | sh
        echo "Nix installation complete."
    }

    # Check if Homebrew is installed
    check_homebrew_installed

    # Check if Nix is installed
    if ! command -v nix &> /dev/null; then
        install_nix
    else
        echo "Nix is already installed."
    fi

    echo "Installation of Homebrew and Nix completed."
    echo "Next step: run the following command to fetch the configuration:"
    echo "curl -L https://raw.githubusercontent.com/gelleson/laptop-config-remote/refs/heads/master/install.sh | bash -s config"
    echo ""
    echo "This command will clone the configuration files from the repository and set up your Nix environment."
    echo "It's essential to run this step to ensure your Nix settings and packages are aligned with your preferences."
}

# Subcommand: config - Fetch configuration and ensure nix.conf is updated
config() {
    echo "Fetching configuration and ensuring correct Nix settings..."

    # Function to fetch configuration from GitHub repository
    fetch_configuration() {
        if [ ! -d "$CONFIG_DIR" ]; then
            echo "Fetching configuration from GitHub ($CONFIG_REPO)..."
            git clone "$CONFIG_REPO" "$CONFIG_DIR"
            echo "Configuration fetched successfully."
        else
            echo "Configuration directory already exists ($CONFIG_DIR). Skipping fetch."
        fi
    }

    # Function to ensure experimental features are set in nix.conf
    ensure_experimental_features() {
        if [ -f "$NIX_CONF_FILE" ]; then
            if ! grep -q "^experimental-features =.*nix-command flakes" "$NIX_CONF_FILE"; then
                echo "Appending experimental-features to $NIX_CONF_FILE..."
                echo "experimental-features = nix-command flakes" >> "$NIX_CONF_FILE"
            else
                echo "experimental-features already set in $NIX_CONF_FILE."
            fi
        else
            echo "$NIX_CONF_FILE does not exist. Please check your Nix installation."
            exit 1
        fi
    }

    # Fetch the configuration
    fetch_configuration

    # Ensure the correct experimental features are enabled in nix.conf
    ensure_experimental_features

    echo "Configuration and Nix settings ensured."
    echo "Next step: run the following command to activate the configuration:"
    echo "curl -L https://raw.githubusercontent.com/gelleson/laptop-config-remote/refs/heads/master/install.sh | bash -s activate"
    echo ""
    echo "Activating the configuration will apply the Nix settings and enable any services or packages you've defined in your Nix configuration."
    echo "This step is crucial for ensuring your system is set up according to your preferences and for enabling features you may need."
}

# Subcommand: activate - Installs nix-darwin and activates the configuration
activate() {
    echo "Installing nix-darwin and activating the configuration..."

    # Function to install nix-darwin
    install_nix_darwin() {
        echo "Installing nix-darwin..."
        nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
        ./result/bin/darwin-installer
        echo "nix-darwin installation complete."
    }

    # Check if nix-darwin is installed
    if [ ! -f "$HOME/.nixpkgs/darwin-configuration.nix" ]; then
        install_nix_darwin
    else
        echo "nix-darwin is already installed."
    fi

    # Activate the configuration
    echo "Activating configuration with darwin-rebuild..."
    /run/current-system/sw/bin/darwin-rebuild switch --flake "$FLAKE_TARGET"

    $CONFIG_DIR/scripts/update-zed-config.sh
    echo "Configuration activated successfully."
}

# Main script logic for handling subcommands and options
# Check if SH_ACTION environment variable is set
if [ -n "$SH_ACTION" ]; then
    ACTION="$SH_ACTION"
elif [ $# -gt 0 ]; then
    ACTION="$1"
else
    usage
fi

# Execute the subcommand based on the provided action
case "$ACTION" in
    install)
        install
        ;;
    config)
        config
        ;;
    activate)
        activate
        ;;
    --help)
        usage
        ;;
    *)
        echo "Invalid option: $ACTION"
        usage
        ;;
esac
