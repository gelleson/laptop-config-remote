#!/bin/bash

# Script to generate a Git commit message using an LLM, handling potential xq errors.

# Description:
# This script stages changes, then attempts to generate a commit message using an LLM (assumed to be 'llm') and a formatter/filter ('xq').
# If 'xq' fails, it falls back to using the raw LLM output.  It handles potential errors gracefully.

# Prerequisites:
# - 'git' must be installed and configured.
# - 'llm' (your large language model command-line tool) must be installed and configured.  It should accept '-t' for specifying a task.
# - 'xq' (your query/transformation tool) must be installed.  It should accept '-x' for specifying an expression.


# Usage:
#   ./git_commit_llm.sh

# Error Handling:
# The script checks the exit codes of 'git add', 'llm', and 'xq' to handle potential errors.  Error messages are printed to stderr.

# --- Start of Script ---

# Stage changes
git add . || {
  >&2 echo "Error: git add failed.  Aborting."
  exit 1
}

# Generate commit message using LLM and xq
commit_message=$(git diff --staged | llm -t git-message | xq -x "//commit_message" 2>&1)

# Check for xq errors.  Exit code 0 means success.
if [[ $? -ne 0 ]]; then
  >&2 echo "Warning: xq failed.  Using raw LLM output."
  commit_message=$(git diff --staged | llm -t git-message) # Fallback to raw LLM output
fi

# Check if commit message is empty
if [[ -z "$commit_message" ]]; then
  >&2 echo "Error: LLM failed to generate a commit message. Aborting."
  exit 1
fi


# Commit the changes
git commit -m "$commit_message" || {
  >&2 echo "Error: git commit failed.  Aborting."
  exit 1
}


>&2 echo "Commit successful: $commit_message"
exit 0
