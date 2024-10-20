#!/bin/bash

# Script to generate a Git commit message using an LLM, handling potential errors.

# Description:
# This script stages changes, then attempts to generate a commit message using an LLM
# (assumed to be 'llm') and a formatter/filter ('xq'). If 'xq' fails, it falls back to
# using the raw LLM output. It handles potential errors gracefully.  The script outputs
# a success or error message to stderr, along with the commit message (if successful).


# Prerequisites:
# - 'git' must be installed and configured.
# - 'llm' (your large language model command-line tool) must be installed and configured.
#   It should accept '-t' for specifying a task (e.g., '-t git-message').
# - 'xq' (your query/transformation tool) must be installed.  It should accept '-x' for
#   specifying an expression (e.g., '-x "//commit_message"').


# Usage:
#   ./git_commit_llm.sh


# --- Start of Script ---

# Stage changes
git add . || {
  >&2 echo "Error: git add failed.  Aborting."
  exit 1
}

# Generate commit message using LLM and xq
git_diff=$(git diff --staged)
commit_message=$(echo "$git_diff" | llm -t git-message 2>&1 | xq -x "//commit_message" 2>&1)

# Check for xq errors. Exit code 0 means success.
if [[ $? -ne 0 ]]; then
  >&2 echo "Warning: xq failed. Using raw LLM output."
  commit_message=$(echo "$git_diff" | llm -t git-message 2>&1) # Fallback to raw LLM output
fi

# Check if commit message is empty
if [[ -z "$commit_message" ]]; then
  >&2 echo "Error: LLM failed to generate a commit message. Aborting."
  exit 1
fi

# Commit the changes
git commit -m "$commit_message" || {
  >&2 echo "Error: git commit failed with message: $(git status)"
  exit 1
}

>&2 echo "Commit successful:"
>&2 echo "$commit_message"
exit 0
