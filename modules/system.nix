{ pkgs, ... }: {
  nix.settings.experimental-features = "nix-command flakes";

  system.stateVersion = 4;
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.gelleson = {
    name = "gelleson";
    home = "/Users/gelleson";
  };

  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  security.pam.services.sudo_local.touchIdAuth = true;
}
