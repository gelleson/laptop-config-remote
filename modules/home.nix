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
        '';
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
        git-commit = "~/.config/nix-darwin/scripts/git-commit-with-llm.sh";
        k = "kubectl";
        zupd = "source ~/.zshrc";
        j = "just";
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
