#!/bin/bash

# ------------------------------------------------------------------------------
# Script Name: install_nix_darwin.sh
# Description: This script checks for the installation of Homebrew and Nix,
#              installs them if they are not present, and then installs
#              nix-darwin. It also fetches configuration from a GitHub repository
#              and runs the darwin-rebuild command to activate the configuration.
#
# Usage:
#   1. Save this script as install_nix_darwin.sh.
#   2. Make it executable: chmod +x install_nix_darwin.sh
#   3. Run the script: ./install_nix_darwin.sh
#
# Requirements:
# - Bash shell
#
# Author: Gelleson
# Date: 2024-10-12
# ------------------------------------------------------------------------------

# Function to install Homebrew
install_homebrew() {
    echo "Homebrew is not installed. Installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "Homebrew installation complete."
}

# Function to install Nix
install_nix() {
    echo "Nix is not installed. Installing now..."
    curl -L https://nixos.org/nix/install | sh
    echo "Nix installation complete."
}

# Function to install nix-darwin
install_nix_darwin() {
    echo "Installing nix-darwin..."
    nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
    ./result/bin/darwin-installer
    echo "nix-darwin installation complete."
}

# Function to ensure experimental features are set in nix.conf
ensure_experimental_features() {
    NIX_CONF="/etc/nix/nix.conf"

    if [ -f "$NIX_CONF" ]; then
        if ! grep -q "^experimental-features =.*nix-command flakes" "$NIX_CONF"; then
            echo "Appending experimental-features to $NIX_CONF..."
            echo "experimental-features = nix-command flakes" >> "$NIX_CONF"
        else
            echo "experimental-features already set in $NIX_CONF."
        fi
    else
        echo "$NIX_CONF does not exist. Please check your Nix installation."
        exit 1
    fi
}

# Function to fetch configuration from GitHub repository
fetch_configuration() {
    CONFIG_DIR="$HOME/.config/nix-darwin"

    if [ ! -d "$CONFIG_DIR" ]; then
        echo "Fetching configuration from GitHub..."
        git clone https://github.com/gelleson/laptop-config-remote "$CONFIG_DIR"
        echo "Configuration fetched successfully."
    fi
}

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    install_homebrew
else
    echo "Homebrew is already installed."
fi

# Check if Nix is installed
if ! command -v nix &> /dev/null; then
    install_nix
else
    echo "Nix is already installed."
fi

# Fetch configuration from GitHub repository
fetch_configuration

# Install nix-darwin if it's not already installed (you may want to check differently)
if [ ! -f "$HOME/.nixpkgs/darwin-configuration.nix" ]; then
    install_nix_darwin
else
    echo "nix-darwin is already installed."
fi

# Ensure experimental features are set in nix.conf before running darwin-rebuild
ensure_experimental_features

# Run darwin-rebuild to activate the configuration
echo "Activating configuration with darwin-rebuild..."
/run/current-system/sw/bin/darwin-rebuild switch --flake ~/.config/nix-darwin#my-mac

echo "Configuration activated successfully."
