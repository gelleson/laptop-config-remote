#!/bin/bash

# Description: Generates a commit message based on the provided flag.
# Usage:
#   ./generate_commit_message.sh --staged          # Use staged changes (--cached)
#   ./generate_commit_message.sh                   # Use unstaged changes
#   ./generate_commit_message.sh -t <jira-ticket>  # Include Jira ticket ID in the message
#   ./generate_commit_message.sh --staged -t <jira-ticket>  # Use staged changes and include Jira ticket
#   ./generate_commit_message.sh <buyers-code>     # Shortcut for BUYERS code (e.g., '123' -> 'BUYERS-123')

# Default to unstaged changes
DIFF_COMMAND="git diff"

# Initialize variables
JIRA_TICKET=""
BUYERS_CODE=""

# Function to display usage
usage() {
    echo "Usage: $0 [--staged] [-t <jira-ticket>] [<buyers-code>]"
    echo "  --staged    Use staged changes (--cached)"
    echo "  -t          Include Jira ticket ID in the commit message"
    echo "  <buyers-code>  Shortcut for BUYERS code (e.g., '123' -> 'BUYERS-123')"
    exit 1
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --staged)
            DIFF_COMMAND="git diff --cached"
            shift
            ;;
        -t)
            if [[ -n "$2" ]]; then
                JIRA_TICKET="$2"
                shift 2
            else
                echo "Error: -t requires a Jira ticket ID."
                usage
            fi
            ;;
        *)
            # Assume it's a BUYERS code shortcut
            if [[ "$1" =~ ^[0-9]+$ ]]; then
                JIRA_TICKET="BUYERS-$1"
            else
                echo "Error: Invalid BUYERS code shortcut. Must be a number."
                usage
            fi
            shift
            ;;
    esac
done

# Check for changes based on the selected diff command
if $DIFF_COMMAND --quiet; then
    echo "No changes to process."
    exit 0
fi

# Generate and extract commit message
COMMIT_MESSAGE=$($DIFF_COMMAND | llm -t git-message | xq -x '//commit_message' )

# Check if a commit message was generated
if [[ -z "$COMMIT_MESSAGE" ]]; then
    echo "No commit message generated."
    exit 1
fi

# Replace module names with JIRA_TICKET if provided
if [[ -n "$JIRA_TICKET" ]]; then
    # Use regex to replace module names in the commit message
    # Example: Replaces "feat(templates)" with "feat(PROJ-123)"
    COMMIT_MESSAGE=$(echo "$COMMIT_MESSAGE" | sed -E "s/\(([^)]+)\)/($JIRA_TICKET)/g")
fi


# Print the commit message
echo "$COMMIT_MESSAGE"
