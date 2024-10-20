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

    # Programming languages and runtime managers
    go
    gleam
    bun
    deno
    flutter
    rye  # Python project manager
    fnm  # Fast Node Manager

    # Shell enhancements
    atuin  # Shell history sync
    zsh-powerlevel10k

    # Container and virtualization
    docker

    # Cloud and infrastructure tools
    terraform
    flyctl

    # Security tools
    age
    age-plugin-yubikey

    # JetBrains IDEs
    jetbrains.webstorm
    jetbrains.rust-rover
    jetbrains.pycharm-professional
    jetbrains.idea-ultimate
    jetbrains.goland

    # Fonts
    jetbrains-mono

    # Terminal emulator
    alacritty

    # Network tools
    openssh
    wget
    httpie

    # Additional tools (you might want to categorize these further)
    # ...
  ];
}
