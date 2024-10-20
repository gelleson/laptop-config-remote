{ config, pkgs, home, ... }:{
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

    home.file."Library/Application Support/io.datasette.llm/aliases.json".text = ''
    {
        "l1": "llama3.2:1b",
        "l3": "llama3.2:3b",
        "hku": "claude-3-haiku-20240307",
        "f": "gemini-1.5-flash-002"
    }
    '';

    home.file."Library/Application Support/io.datasette.llm/default_model.txt".text = ''
    gemini-1.5-flash-002
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
}
