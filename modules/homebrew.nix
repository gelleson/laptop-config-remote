{
  homebrew.enable = true;
  homebrew.onActivation.autoUpdate = true;

  homebrew.brews = [
    "rust"
    "llm"
    "xq"
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
  ];

  homebrew.masApps = {
    "session" = 1521432881;
    "pages" = 409201541;
    "numbers" = 409203825;
    "excel" = 462058435;
    "telegram" = 747648890;
    # Add more apps as needed
  };
}
