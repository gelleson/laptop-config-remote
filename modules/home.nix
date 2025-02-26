{ pkgs, ... }: {
    home.stateVersion = "24.05";

    # Enable home-manager
    programs.home-manager.enable = true;
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        initExtra = ''
        eval $(fnm env)
        source "$HOME/.rye/env"
        . "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
        autoload -Uz bashcompinit && bashcompinit
        . "${pkgs.asdf-vm}/share/asdf-vm/completions/asdf.bash"

        load-nvmrc() {
          DEFAULT_NODE_VERSION="$(fnm ls | awk '/default/{print $2}')"
          CURRENT_NODE_VERSION="$(fnm current)"
          REQUIRED_NODE_VERSION=""

          if [[ -f .nvmrc && -r .nvmrc ]]; then
            REQUIRED_NODE_VERSION="$(cat .nvmrc)"

            if [[ $CURRENT_NODE_VERSION != $REQUIRED_NODE_VERSION ]]; then
              if fnm ls | grep -q $REQUIRED_NODE_VERSION; then
                fnm use $REQUIRED_NODE_VERSION
              else
                fnm install $REQUIRED_NODE_VERSION
                fnm use $REQUIRED_NODE_VERSION
              fi
            fi
          else
            if [[ $CURRENT_NODE_VERSION != $DEFAULT_NODE_VERSION ]]; then
              fnm use $DEFAULT_NODE_VERSION
            fi
          fi
        }

        export PATH="$HOME/.local/bin:$PATH"
        export PATH="$HOME/.bun/bin:$PATH"
        [[ -s "$(brew --prefix sdkman-cli)/libexec/bin/sdkman-init.sh" ]] && source "$(brew --prefix sdkman-cli)/libexec/bin/sdkman-init.sh"
        add-zsh-hook chpwd load-nvmrc
        load-nvmrc
        source ~/.secrets
        export PATH="/Users/gelleson/.deno/bin:$PATH"
        '';

        oh-my-zsh = {
            enable = true;
            plugins = [ ];
            theme = "awesomepanda";
        };
    };
    programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
        options = [
            "--cmd cd"
        ];
    };

    programs.zsh.shellAliases = {
        updos = "~/.config/nix-darwin/install.sh activate";
        updos-edit = "zed ~/.config/nix-darwin/";
        ls = "eza";
        ll = "eza -alh";
        cat = "bat";
        llm-update-plugins = "sh ~/.config/nix-darwin/codes/llm-install-plugins.sh";
        git-message = "git diff --staged | llm -t git-message | xq -x //commit_message";
        gm = "git diff {GIT_ARGS:''} | llm -t git-message | xq -x //commit_message";

        git-commit = "~/.config/nix-darwin/scripts/git-commit-with-llm.sh";
        k = "kubectl";
        zupd = "source ~/.zshrc";
        j = "just";
        ils = "jira issue list -a$(jira me)";

        llm-message = "~/.config/nix-darwin/scripts/git-commit-message.sh";
        llm-price = "~/.config/nix-darwin/scripts/llm-price.py";
        gp = "~/.config/nix-darwin/scripts/git-push.sh";
        low = "tr '[:upper:]' '[:lower:]'";
    };

    programs.git = {
      enable = true;
      userName = "Altynbek Kaliakbarov";
      userEmail = "go.gelleson@gmail.com";
      extraConfig = {
        user = {
          nickname = "gelleson";
        };
      };
    };

    programs.alacritty = {
        enable = true;
        settings = {

          font = rec {
            normal.family = "Menlo";
            size = 16;
            bold = { style = "Bold"; };
          };

          window.padding = {
            x = 2;
            y = 2;
          };

          cursor.style = "Beam";
        };
      };

    programs.atuin = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
    };

    imports = [
    ./files/templates.nix
    ./files/settings.nix
    ./files/folders.nix
    ];
}
