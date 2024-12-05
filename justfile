# commit message
commit:
    @./scripts/git-commit-with-llm.sh

# Push to the remote repo
push: commit
    @git push origin master

update:
    @nix flake update
