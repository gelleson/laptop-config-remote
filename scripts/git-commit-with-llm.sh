#!/bin/bash

# Script to generate a Git commit message using an LLM, handling potential errors.

# Description:
# This script stages changes, then attempts to generate a commit message using an LLM
# (assumed to be 'llm') and a formatter/filter ('xq'). If 'xq' fails, it falls back to
# using the raw LLM output. It handles potential errors gracefully.  The script outputs
# a success or error message to stderr, along with the final commit message (if successful) and the raw LLM response.


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

# Generate commit message using LLM
git_diff=$(git diff --staged)
llm_response=$(echo "$git_diff" | llm -t git-message 2>&1)

# Check for LLM errors.  Exit code 0 means success.
if [[ $? -ne 0 ]]; then
  >&2 echo "Error: LLM failed to generate a commit message: $llm_response. Aborting."
  exit 1
fi

# Process LLM output with xq
commit_message=$(echo "$llm_response" | xq -x "//commit_message" 2>&1)

# Check for xq errors. Exit code 0 means success.
if [[ $? -ne 0 ]]; then
  >&2 echo "Warning: xq failed. Using raw LLM output."
  commit_message="$llm_response" # Fallback to raw LLM output
fi

# Check if commit message is empty
if [[ -z "$commit_message" ]]; then
  >&2 echo "Error:  No commit message generated after LLM and xq processing. Aborting."
  exit 1
fi

# Commit the changes
git commit -m "$commit_message" --quiet || {
  >&2 echo "Error: git commit failed. Git status: $(git status). LLM Response: $llm_response"
  exit 1
}

>&2 echo "Commit successful:"
>&2 echo "Commit Message: $commit_message"
exit 0
