{ pkgs, ... }: {
    home.stateVersion = "24.05";

    # Enable home-manager
    programs.home-manager.enable = true;
    programs.zsh = {
        enable = true;
    };
    programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
        options = [
            "--cmd cd"
        ];
    };

    programs.zsh.shellAliases = {
        updos = "~/.config/nix-darwin/install.sh";
        updos-edit = "zed ~/.config/nix-darwin/";
        ls = "eza";
        ll = "eza -alh";
        cat = "bat";
        llm-update-plugins = "sh ~/.config/nix-darwin/llm-install-plugins.sh";
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


    home.file.".config/zed/settings.json".text = ''
    // Zed setting
    //
    // For information on how to configure Zed, see the Zed
    // documentation: https://zed.dev/docs/configuring-zed
    //
    // To see all of Zed's default settings without changing your
    // custom settings, run `zed: open default settings` from the
    // command palette (cmd-shift-p / ctrl-shift-p)
    {
      "ui_font_size": 16,
      "autosave": "on_focus_change",
      "buffer_font_size": 18,
      "base_keymap": "JetBrains",
      "format_on_save": "on",
      "git_status": true,
      "theme": {
        "mode": "system",
        "light": "One Light",
        "dark": "One Dark"
      },
      "buffer_font_family": "JetBrains Mono"
    }
    '';

    home.file.".gitmessage".text = ''
      # Commit message
      # gelleson

      # Why:

      # This change is necessary because

      # How:

      # This change addresses the need by

      # Refs:
    '';

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

          shell.program = "${pkgs.zsh}/bin/zsh";

          cursor.style = "Beam";
        };
      };

    programs.atuin = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
    };

}
