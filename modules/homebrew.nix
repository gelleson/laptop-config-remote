{
  homebrew.enable = true;
  homebrew.onActivation.autoUpdate = true;

  homebrew.brews = [
    "rust"
    "llm"
    "xq"
    "gdal"
    "deno"
    "postgresql"
    "libffi"
    "uv"
    "rustup"
    "ruby"
    "mockery"
    "goreleaser"
    "gleam"
    "erlang"
    "oven-sh/bun/bun"
  ];

  homebrew.casks = [
    "arc"
    "slack"
    "visual-studio-code"
    "zed"
    "raycast"
    "warp"
    "jan"
    "notion-calendar"
    "poe"
    "chatgpt"
    "ollama"
    "obsidian"
    "duckduckgo"
    "coconutbattery"
    "outline-manager"
    "zen-browser"
    "goland"
    "webstorm"
    "rustrover"
    "pycharm"
    "datagrip"
    "intellij-idea"
  ];

  homebrew.masApps = {
    "session" = 1521432881;
    "pages" = 409201541;
    "numbers" = 409203825;
    "excel" = 462058435;
    "telegram" = 747648890;
    "outline-vpn" = 1356178125;
    # Add more apps as needed
  };
}
