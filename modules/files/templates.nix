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

    home.file."Library/Application Support/io.datasette.llm/templates/github-release.yaml".text = ''
    defaults:
        model: claude-3-haiku
    prompt: |
        You are tasked with generating an informative GitHub release note based on the differences (diff) between two versions of code. This release note should highlight the key changes, improvements, and fixes in a clear and concise manner.

        You will be provided with the diff content between two versions. Here is the diff:

        <diff>
        $input
        </diff>

        Analyze the diff carefully, paying attention to:
        1. Added, modified, and deleted files
        2. Changes in code functionality
        3. New features or enhancements
        4. Bug fixes
        5. Performance improvements
        6. Documentation updates

        Based on your analysis, generate a release note that:
        1. Summarizes the most important changes
        2. Groups related changes under appropriate headings (e.g., "New Features", "Bug Fixes", "Improvements")
        3. Uses clear and concise language
        4. Provides enough detail for users to understand the impact of the changes
        5. Mentions any breaking changes or important notes for users upgrading to this version

        Format the release note as follows:
        1. Start with a brief overview of the release
        2. Use bullet points for each change
        3. Group changes under appropriate headings
        4. Include a "Full Changelog" link at the end (you can use a placeholder URL)

        This is target version <version>$version</version>

        Here are two examples of good release notes:

        Example 1:
        ```
        ## v1.2.0 - Performance Boost and Bug Fixes

        This release focuses on improving overall performance and fixing several critical bugs.

        ### Improvements
        - Optimized database queries, resulting in a 30% faster load time for large datasets
        - Reduced memory usage in the image processing module

        ### Bug Fixes
        - Fixed a crash that occurred when processing malformed JSON input
        - Resolved an issue where the export function would fail for files larger than 1GB

        ### Full Changelog
        For a complete list of changes, please see the [full changelog](https://github.com/example/repo/compare/v1.1.0...v1.2.0).
        ```

        Example 2:
        ```
        ## v2.5.0 - New UI Components and API Enhancements

        We're excited to introduce several new UI components and improvements to our API in this release.

        ### New Features
        - Added a customizable date picker component
        - Introduced a new "dark mode" theme option

        ### API Enhancements
        - Added support for batch processing in the /users endpoint
        - Implemented rate limiting for better API stability

        ### Breaking Changes
        - The `user.getProfile()` method now returns a Promise instead of using a callback

        ### Full Changelog
        For a detailed list of all changes, please refer to the [full changelog](https://github.com/example/repo/compare/v2.4.0...v2.5.0).
        ```

        Now, based on the provided diff and the guidelines above, generate an informative GitHub release note. Write your release note inside <release_note> tags.
    '';
}
