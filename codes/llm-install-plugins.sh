#!/bin/bash

# Script to install LLM plugins using the llm command.
#
# Author: galleson
#
# This script checks if the 'llm' command is installed on the system.
# If it is not installed, the script exits with a message.
# It proceeds to install a predefined list of LLM plugins.
# After attempting to install each plugin, the script reports
# whether the installation was successful or not.

# Check if the llm command is installed
if ! command -v llm &> /dev/null
then
    echo "llm command not found. Please install it first."
    exit 1
fi

# Array of LLM plugins to install
plugins=(llm-together llm-groq llm-gemini)

# Install the LLM plugins
echo "Installing LLM plugins..."

for plugin in "${plugins[@]}"; do
    llm install "$plugin"
    if [ $? -eq 0 ]; then
        echo "$plugin installed successfully."
    else
        echo "Failed to install $plugin."
    fi
done
