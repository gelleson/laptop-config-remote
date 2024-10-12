{
  description = "My system configuration with Homebrew and Neofetch";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      services.nix-daemon.enable = true;
      nix.settings.experimental-features = "nix-command flakes";

      system.stateVersion = 4;
      nixpkgs.hostPlatform = "aarch64-darwin";

      users.users.gelleson = {
        name = "gelleson";
        home = "/Users/gelleson";
      };

      programs.zsh.enable = true;

      # Enable Homebrew
      homebrew.enable = true;
      homebrew.onActivation.autoUpdate = true; # Auto-update Homebrew on activation

      homebrew.brews = [
        "colima"
        "rust"
      ];

      # Specify Homebrew casks only (no Go)
      homebrew.casks = [
        "arc"
        "slack"
        "visual-studio-code"
        "zed"
        "webstorm"
        "pycharm"
        "goland"
        "raycast"
        "alacritty"
        "jan"
      ];

      # Install neofetch and Go via system packages
      environment.systemPackages = [
        pkgs.neofetch # Add neofetch to system packages
        pkgs.go # Add Go to system packages
        pkgs.git
        pkgs.tree
        pkgs.rye
        pkgs.atuin
      ];

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      security.pam.enableSudoTouchIdAuth = true;
    };
  in
  {
    darwinConfigurations.my-mac = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
      ];
    };
  };
}
