#!/bin/bash

# Script Name: git_push.sh
# Get the current branch name
current_branch=$(git branch --show-current)

# Check if we are on a branch
if [ -z "$current_branch" ]; then
  echo "Not on a branch. Please checkout a branch before pushing."
  exit 1
fi

# Construct the push command
push_command="git push origin $current_branch"

# Execute the push command
echo "Pushing to origin $current_branch..."
git push origin "$current_branch"

# Check the exit status of the push command
if [ $? -eq 0 ]; then
  echo "Successfully pushed to origin $current_branch"
else
  echo "Failed to push to origin $current_branch"
  exit 1
fi
