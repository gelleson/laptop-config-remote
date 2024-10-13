{ config, pkgs, home, ... }:{
    home.file."Library/Application Support/io.datasette.llm/templates/git-message.yaml".text = ''
    defaults:
        model: claude-3-haiku
    prompt: |
        You are tasked with generating a conventional commit message based on a git diff. The git diff will be provided to you, and you should analyze it to create an appropriate commit message.

        First, here's the git diff you'll be working with:

        <git_diff>
        {{$input}}
        </git_diff>

        Conventional commit messages follow this format:
        <type>[optional scope]: <description>

        Where:
        - type: describes the kind of change (e.g., feat, fix, docs, style, refactor, test, chore)
        - scope: (optional) describes what is affected by the change
        - description: a brief summary of the change

        Analyze the provided git diff carefully. Pay attention to:
        1. The files that have been modified
        2. The nature of the changes (additions, deletions, modifications)
        3. The content of the changes

        Based on your analysis, determine the most appropriate type for this commit. Common types include:
        - feat: A new feature
        - fix: A bug fix
        - docs: Documentation only changes
        - style: Changes that do not affect the meaning of the code (white-space, formatting, etc)
        - refactor: A code change that neither fixes a bug nor adds a feature
        - test: Adding missing tests or correcting existing tests
        - chore: Changes to the build process or auxiliary tools and libraries

        Next, create a brief, clear description of the change. This should be concise but informative, summarizing the main purpose of the commit.

        Combine the type and description to form the commit message. If a scope is clearly identifiable and would add valuable context, include it as well.

        Output your generated commit message within <commit_message> tags. Ensure it follows the conventional commit format.

        <example>
        <commit_message>
        fix(authentication): resolve issue with user login timeout
        </commit_message>
        </example>

        Remember to keep the commit message concise, ideally under 50 characters if possible, but informative enough to understand the purpose of the commit at a glance.
        Only git message without any explanation
    '';
}
