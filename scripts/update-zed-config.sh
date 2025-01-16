#!/bin/bash
# ------------------------------------------------------------------------------
# Script Name: generate_zed_settings.sh
# Description: Copies the default settings of Zed editor to settings.json and formats it using jq.
#              This ensures that the settings file is properly structured and easy to read.
#
# Usage: Run this script to update the Zed editor settings file.
#
# Requirements:
# - Bash shell
# - jq installed (for JSON formatting)
#
# Author: gelleson
# Date: 2025-01-17
# ------------------------------------------------------------------------------

cat ~/.config/zed/default-settings.json | jq > ~/.config/zed/settings.json
