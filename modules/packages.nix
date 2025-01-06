{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # System utilities
    neofetch
    tree
    bat
    fd
    procs
    dust
    jq
    ripgrep
    tokei
    hyperfine
    btop
    tealdeer
    bandwhich
    zoxide
    htop
    killall
    transmission_4
    eza
    zellij
    keepassxc
    yq
    just
    pre-commit

    # Version control and development tools
    git
    gh
    delta
    act
    kubectl
    colima
    turso-cli

    # Programming languages and runtime managers
    go
    flutter
    rye  # Python project manager
    fnm  # Fast Node Manager
    zig

    # Shell enhancements
    atuin  # Shell history sync
    zsh-powerlevel10k
    asdf-vm

    # Container and virtualization
    docker

    # Cloud and infrastructure tools
    terraform
    flyctl

    # Security tools
    age
    age-plugin-yubikey


    # Fonts
    jetbrains-mono

    # Terminal emulator
    alacritty

    # Network tools
    openssh
    wget
    httpie

    oh-my-zsh

    jira-cli-go
  ];
}
