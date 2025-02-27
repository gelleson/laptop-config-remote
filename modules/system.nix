{ pkgs, ... }: {
  nix.settings.experimental-features = "nix-command flakes";

  ids.gids.nixbld = 350;
  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.gelleson = {
    name = "gelleson";
    home = "/Users/gelleson";
  };

  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  security.pam.services.sudo_local.touchIdAuth = true;
}
