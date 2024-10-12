{
  homebrew.enable = true;
  homebrew.onActivation.autoUpdate = true;

  homebrew.brews = [
    "colima"
    "rust"
    "llm"
  ];

  homebrew.casks = [
    "arc"
    "slack"
    "visual-studio-code"
    "zed"
    "raycast"
    "warp"
    "jan"
  ];

  homebrew.masApps = {
    "session" = 1521432881;
    "pages" = 409201541;
    "numbers" = 409203825;
    "excel" = 462058435;
    # Add more apps as needed
  };
}
