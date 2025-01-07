#!/bin/bash

# Description: Generates a commit message based on the provided flag.
# Usage:
#   ./generate_commit_message.sh --staged    # Use staged changes (--cached)
#   ./generate_commit_message.sh             # Use unstaged changes

# Default to unstaged changes
DIFF_COMMAND="git diff"

# Parse arguments
if [[ "$1" == "--staged" ]]; then
    DIFF_COMMAND="git diff --cached"
fi

# Check for changes based on the selected diff command
if $DIFF_COMMAND --quiet; then
    echo "No changes to process."
    exit 0
fi

# Generate and extract commit message
commit_message=$($DIFF_COMMAND | llm -t git-message | xq -x '//commit_message')

# Check if a commit message was generated
if [[ -z "$commit_message" ]]; then
    echo "No commit message generated."
    exit 1
fi

# Print the commit message
echo "Generated Commit Message:"
echo "$commit_message"
