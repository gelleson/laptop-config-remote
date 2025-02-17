{ config, pkgs, home, lib, ... }:

let
  # Define zedConfig as a Nix attribute set
  zedConfig = {
    ui_font_size = 16;
    autosave = "on_focus_change"; # Changed to camelCase as per Zed's expectations
    buffer_font_size = 18;
    base_keymap = "JetBrains"; # Typically lowercase
    format_on_save = "on"; # Changed to boolean
    git_status = true;
    theme = {
      mode = "system";
      light = "Atelier Savanna Light";
      dark = "Vintergata";
    };
    buffer_font_family = "JetBrains Mono";
    features = {
      inline_completion_provider = "supermaven";
    };

    assistant = {
      enabled = true;
      version = "2";
      button = true;
      dock = "right";
      default_model = {
        provider = "openai";
        model = "deepseek/deepseek-chat";
      };
    };
    language_models = {
      openai = {
        api_url = "https://openrouter.ai/api/v1";
        available_models = [
          {
            name = "deepseek/deepseek-chat";
            display_name = "DeepChat V3";
            max_tokens = 131072;
          }
          {
            name = "meta-llama/llama-3.1-405b-instruct:free";
            display_name = "Llama 3.1";
            max_tokens = 8192;
          }
          {
            name = "nousresearch/hermes-3-llama-3.1-405b";
            display_name = "Hermes 3.1 Lama 3.1 405b";
            max_tokens = 131072;
          }
          {
            name = "qwen/qvq-72b-preview";
            display_name = "Qwen 72b";
            max_tokens = 128000;
          }
          {
            name = "deepseek/deepseek-r1";
            display_name = "Deepseek R1";
            max_tokens = 128000;
          }
          {
            name = "mistralai/codestral-mamba";
            display_name = "CodeStral Mamba";
            max_tokens = 256000;
          }
          {
            name = "openai/o3-mini-high";
            display_name = "O3 Mini High";
            max_tokens = 200000;
          }
          {
            name = "openai/o3-mini";
            display_name = "O3 Mini";
            max_tokens = 200000;
          }
          {
            name = "mistralai/codestral-2501";
            display_name = "CodeStral 2501";
            max_tokens = 256000;
          }
          {
            name = "google/gemini-2.0-flash-001";
            display_name = "Gemini 2.0 Flash 001";
            max_tokens = 1000000;
          }
        ];
        version = "1";
      };
    };
  };
in
{
  # Configure Ghostty
  home.file.".config/ghostty/config".text = ''
    font-family = "JetBrains Mono"
    font-size = 22
    theme = Blue Matrix
    window-padding-x = 2
    background-opacity = 0.8
  '';

  # Write zed-conf-settings.json by converting zedConfig to JSON
  home.file.".config/zed/default-settings.json" = {
    text = builtins.toJSON zedConfig;
  };

  home.file.".config/zed/themes/vintergata.json".text = ''
    {
      "$schema": "https://zed.dev/schema/themes/v0.1.0.json",
      "name": "Vintergata",
      "author": "Webhooked",
      "themes": [
        {
          "name": "Vintergata",
          "appearance": "dark",
          "style": {
            "border": "#fafafa09",
            "border.variant": "#7282A133",
            "border.focused": "#7282A177",
            "border.selected": "#7282A1bb",
            "border.transparent": "#00000000",
            "border.disabled": null,
            "elevated_surface.background": "#191920ff",
            "surface.background": "#101012FF",
            "background": "#191920FF",
            "element.background": "#191920ff",
            "element.hover": "#191920FF",
            "element.active": "#191920FF",
            "element.selected": "#191920FF",
            "element.disabled": "#7282A1FF",
            "drop_target.background": "#191920FF",
            "ghost_element.background": "#00000000",
            "ghost_element.hover": "#7282A135",
            "ghost_element.active": "#7282A150",
            "ghost_element.selected": "#7282A125",
            "ghost_element.disabled": "#ff2e18ff",
            "text": "#fafafaff",
            "text.muted": "#7282A1FF",
            "text.placeholder": "#7282A180",
            "text.disabled": "#7282A150",
            "text.accent": "#4fe1c5ff",
            "icon": null,
            "icon.muted": null,
            "icon.disabled": null,
            "icon.placeholder": null,
            "icon.accent": null,
            "status_bar.background": "#101012bb",
            "title_bar.background": "#101012bb",
            "toolbar.background": "#101012ff",
            "tab_bar.background": "#101012bb",
            "tab.inactive_background": "#191920ff",
            "tab.active_background": "#101012ff",
            "search.match_background": "#7282A1ff",
            "panel.background": "#101012ff",
            "panel.focused_border": null,
            "pane.focused_border": null,
            "scrollbar_thumb.background": "#7282A177",
            "scrollbar.thumb.hover_background": "#7282A1FF",
            "scrollbar.thumb.border": "#00000000",
            "scrollbar.track.background": "#101012ff",
            "scrollbar.track.border": "#7282A144",
            "editor.foreground": "#fafafaff",
            "editor.background": "#101012ff",
            "editor.gutter.background": "#101012ff",
            "editor.subheader.background": "#191920ff",
            "editor.active_line.background": "#7282A133",
            "editor.highlighted_line.background": "#7282A1ff",
            "editor.line_number": "#7282A180",
            "editor.active_line_number": "#fafafaff",
            "editor.invisible": "#fafafa30",
            "editor.wrap_guide": "#fafafa15",
            "editor.active_wrap_guide": "#fafafa35",
            "editor.document_highlight.read_background": null,
            "editor.document_highlight.write_background": null,
            "link_text.hover": "#4fe1c5ff",
            "conflict": "#0dffaeff",
            "conflict.background": "#0dffae33",
            "conflict.border": "#0dffae20",
            "created": "#0cf566ff",
            "created.background": "#0cf56633",
            "created.border": "#0cf56620",
            "deleted": "#ff2e18ff",
            "deleted.background": "#ff2e1833",
            "deleted.border": "#ff2e1820",
            "error.background": "#101012FF",
            "error.border": "#ff2e18ff",
            "hidden": "#7282A180",
            "hidden.background": "#101012FF",
            "hidden.border": "#7282A180",
            "hint": "#7282A1ff",
            "hint.background": null,
            "hint.border": null,
            "ignored": "#7282A150",
            "ignored.background": "#191920ff",
            "ignored.border": null,
            "info": null,
            "info.background": "#101012FF",
            "info.border": null,
            "modified": "#00e8dcff",
            "modified.background": null,
            "modified.border": null,
            "predictive": "#B2B2B2FF",
            "predictive.background": null,
            "predictive.border": null,
            "renamed": null,
            "renamed.background": "#101012FF",
            "renamed.border": null,
            "success": null,
            "success.background": "#101012FF",
            "success.border": null,
            "unreachable": null,
            "unreachable.border": null,
            "warning": null,
            "warning.background": "#101012FF",
            "warning.border": null,
            "players": [
              {
                "cursor": "#93B6C8ff",
                "background": "#93B6C8ff",
                "selection": "#93B6C833"
              },
              {
                "cursor": "#0cf566ff",
                "background": "#0cf566ff",
                "selection": "#0cf56633"
              },
              {
                "cursor": "#00e8dcff",
                "background": "#00e8dcff",
                "selection": "#00e8dc33"
              },
              {
                "cursor": "#0dffaeff",
                "background": "#0dffaeff",
                "selection": "#0dffae33"
              },
              {
                "cursor": "#4fe1c5ff",
                "background": "#4fe1c5ff",
                "selection": "#4fe1c533"
              },
              {
                "cursor": "#0dcbffff",
                "background": "#0dcbffff",
                "selection": "#0dcbff33"
              },
              {
                "cursor": "#ff2e18ff",
                "background": "#ff2e18ff",
                "selection": "#ff2e1833"
              }
            ],
            "syntax": {
              "attribute": {
                "color": null,
                "font_style": null,
                "font_weight": null
              },
              "boolean": {
                "color": "#00e8dcff",
                "font_style": null,
                "font_weight": null
              },
              "comment": {
                "color": "#7282A1ff",
                "font_style": null,
                "font_weight": null
              },
              "comment.doc": {
                "color": "#00e8dcff",
                "font_style": null,
                "font_weight": null
              },
              "constant": {
                "color": "#00e8dcff",
                "font_style": null,
                "font_weight": null
              },
              "constructor": {
                "color": "#00e8dcff",
                "font_style": null,
                "font_weight": null
              },
              "embedded": {
                "color": "#fafafaff",
                "font_style": null,
                "font_weight": null
              },
              "emphasis": {
                "color": "#0dffaeff",
                "font_style": "italic",
                "font_weight": null
              },
              "emphasis.strong": {
                "color": "#0dcbffff",
                "font_style": null,
                "font_weight": 700
              },
              "enum": {
                "color": "#93B6C8ff",
                "font_style": null,
                "font_weight": null
              },
              "function": {
                "color": "#0cf566ff",
                "font_style": null,
                "font_weight": null
              },
              "hint": {
                "color": "#93B6C8ff",
                "font_style": null,
                "font_weight": 700
              },
              "keyword": {
                "color": "#7282A1FF",
                "font_style": null,
                "font_weight": null
              },
              "label": {
                "color": null,
                "font_style": null,
                "font_weight": null
              },
              "link_text": {
                "color": "#00e8dcff",
                "font_style": "normal",
                "font_weight": null
              },
              "link_uri": {
                "color": "#4fe1c5ff",
                "font_style": null,
                "font_weight": null
              },
              "number": {
                "color": "#93B6C8ff",
                "font_style": null,
                "font_weight": null
              },
              "operator": {
                "color": "#00e8dcff",
                "font_style": null,
                "font_weight": null
              },
              "predictive": {
                "color": null,
                "font_style": "italic",
                "font_weight": null
              },
              "preproc": {
                "color": null,
                "font_style": null,
                "font_weight": null
              },
              "primary": {
                "color": null,
                "font_style": null,
                "font_weight": null
              },
              "property": {
                "color": "#0dcbffff",
                "font_style": null,
                "font_weight": null
              },
              "punctuation": {
                "color": "#00e8dcff",
                "font_style": null,
                "font_weight": null
              },
              "punctuation.bracket": {
                "color": "#B2B2B2FF",
                "font_style": null,
                "font_weight": null
              },
              "punctuation.delimiter": {
                "color": "#00e8dcff",
                "font_style": null,
                "font_weight": null
              },
              "punctuation.list_marker": {
                "color": "#4fe1c5ff",
                "font_style": null,
                "font_weight": null
              },
              "punctuation.special": {
                "color": "#00e8dcff",
                "font_style": null,
                "font_weight": null
              },
              "string": {
                "color": "#0dffaeff",
                "font_style": null,
                "font_weight": null
              },
              "string.escape": {
                "color": "#00e8dcff",
                "font_style": null,
                "font_weight": null
              },
              "string.regex": {
                "color": "#ff2e18ff",
                "font_style": null,
                "font_weight": null
              },
              "string.special": {
                "color": "#00e8dcff",
                "font_style": null,
                "font_weight": null
              },
              "string.special.symbol": {
                "color": "#93B6C8ff",
                "font_style": null,
                "font_weight": null
              },
              "tag": {
                "color": "#93B6C8ff",
                "font_style": null,
                "font_weight": null
              },
              "text.literal": {
                "color": "#0cf566ff",
                "font_style": null,
                "font_weight": null
              },
              "title": {
                "color": "#7282A1FF",
                "font_style": null,
                "font_weight": 400
              },
              "type": {
                "color": "#4fe1c5ff",
                "font_style": null,
                "font_weight": null
              },
              "type.builtin": {
                "color": "#7282A1ff",
                "font_style": null,
                "font_weight": null
              },
              "type.super": {
                "color": "#4fe1c5ff",
                "font_style": "italic",
                "font_weight": null
              },
              "variable": {
                "color": "#fafafaff",
                "font_style": null,
                "font_weight": null
              },
              "variable.parameter": {
                "color": "#0dcbffff",
                "font_style": "italic",
                "font_weight": null
              },
              "variable.special": {
                "color": "#93B6C8ff",
                "font_style": "italic",
                "font_weight": null
              },
              "variant": {
                "color": null,
                "font_style": null,
                "font_weight": null
              }
            },
            "terminal.background": "#101012ff",
            "terminal.foreground": "#fafafaff",
            "terminal.bright_foreground": "#fafafaff",
            "terminal.dim_foreground": "#B2B2B2FF",
            "terminal.ansi.black": "#21222cff",
            "terminal.ansi.bright_black": "#21222cff",
            "terminal.ansi.dim_black": "#21222cff",
            "terminal.ansi.red": "#ff2e18ff",
            "terminal.ansi.bright_red": "#ff2e18ff",
            "terminal.ansi.dim_red": "#ff2e18ff",
            "terminal.ansi.green": "#0cf566ff",
            "terminal.ansi.bright_green": "#0cf566ff",
            "terminal.ansi.dim_green": "#0cf566ff",
            "terminal.ansi.yellow": "#0dffaeff",
            "terminal.ansi.bright_yellow": "#0dffaeff",
            "terminal.ansi.dim_yellow": "#0dffaeff",
            "terminal.ansi.blue": "#9580ffff",
            "terminal.ansi.bright_blue": "#9580ffff",
            "terminal.ansi.dim_blue": "#9580ffff",
            "terminal.ansi.magenta": "#00e8dcff",
            "terminal.ansi.bright_magenta": "#00e8dcff",
            "terminal.ansi.dim_magenta": "#00e8dcff",
            "terminal.ansi.cyan": "#4fe1c5ff",
            "terminal.ansi.bright_cyan": "#4fe1c5ff",
            "terminal.ansi.dim_cyan": "#4fe1c5ff",
            "terminal.ansi.white": "#fafafaff",
            "terminal.ansi.bright_white": "ffffffff",
            "terminal.ansi.dim_white": "#B2B2B2FF"
          }
        }
      ]
    }
  '';
  # Configure Zed theme
  home.file.".config/zed/themes/se.json".text = ''
  {
    "$schema": "https://zed.dev/schema/themes/v0.1.0.json",
    "name": "Sombre Eclat",
    "author": "orenantao@gmail.com",
    "themes": [
      {
        "name": "Sombre Eclat",
        "appearance": "dark",
        "style": {
          "border": "#4C006C",
          "border.variant": "#6A0196",
          "border.focused": "#f7e6fe",
          "border.selected": "#f7e6fe",
          "border.transparent": "#f7e6fe",
          "border.disabled": null,
          "elevated_surface.background": "#000",
          "surface.background": "#000",
          "background": "#000",
          "element.background": "#561223",
          "element.hover": "#00061A",
          "element.active": null,
          "element.selected": "#fd0",
          "element.disabled": null,
          "drop_target.background": "#5518A9",
          "ghost_element.background": "#191919",
          "ghost_element.hover": "#282227",
          "ghost_element.active": null,
          "ghost_element.selected": "#352C37",
          "ghost_element.disabled": null,
          "text": "#F7E9F5",
          "text.muted": "#cacaca",
          "text.placeholder": "#A2A2A2",
          "text.disabled": "#4F4F4F",
          "text.accent": "#8437DE",
          "icon": null,
          "icon.muted": null,
          "icon.disabled": null,
          "icon.placeholder": null,
          "icon.accent": null,
          "status_bar.background": "#1A1A1B",
          "title_bar.background": "#000",
          "title_bar.inactive_background": "#000",
          "toolbar.background": "#000",
          "tab_bar.background": "#000",
          "tab.inactive_background": "#181818",
          "tab.active_background": "#2A2A2A",
          "search.match_background": "#78147A",
          "panel.background": "#000",
          "panel.focused_border": null,
          "pane.focused_border": null,
          "scrollbar_thumb.background": "#281247",
          "scrollbar.thumb.hover_background": null,
          "scrollbar.thumb.border": "#281247",
          "scrollbar.track.background": "#000",
          "scrollbar.track.border": "#000",
          "editor.foreground": "#D2C8E0",
          "editor.background": "#000",
          "editor.gutter.background": "#000",
          "editor.subheader.background": null,
          "editor.active_line.background": "#291647",
          "editor.highlighted_line.background": null,
          "editor.line_number": "#90908a",
          "editor.active_line_number": "#f8f8f2",
          "editor.invisible": "#848484",
          "editor.wrap_guide": null,
          "editor.active_wrap_guide": null,
          "editor.document_highlight.read_background": "#A0006D",
          "editor.document_highlight.write_background": null,
          "terminal.background": "#000",
          "terminal.foreground": "#fff",
          "terminal.bright_foreground": null,
          "terminal.dim_foreground": null,
          "terminal.ansi.black": "#050505",
          "terminal.ansi.bright_black": "#666666",
          "terminal.ansi.dim_black": null,
          "terminal.ansi.red": "#C4265E",
          "terminal.ansi.bright_red": "#f92672",
          "terminal.ansi.dim_red": null,
          "terminal.ansi.green": "#86B42B",
          "terminal.ansi.bright_green": "#A6E22E",
          "terminal.ansi.dim_green": null,
          "terminal.ansi.yellow": "#B3B42B",
          "terminal.ansi.bright_yellow": "#e2e22e",
          "terminal.ansi.dim_yellow": null,
          "terminal.ansi.blue": "#6A7EC8",
          "terminal.ansi.bright_blue": "#819aff",
          "terminal.ansi.dim_blue": null,
          "terminal.ansi.magenta": "#8C6BC8",
          "terminal.ansi.bright_magenta": "#AE81FF",
          "terminal.ansi.dim_magenta": null,
          "terminal.ansi.cyan": "#56ADBC",
          "terminal.ansi.bright_cyan": "#66D9EF",
          "terminal.ansi.dim_cyan": null,
          "terminal.ansi.white": "#e3e3dd",
          "terminal.ansi.bright_white": "#f8f8f2",
          "terminal.ansi.dim_white": null,
          "link_text.hover": null,
          "conflict": null,
          "conflict.background": null,
          "conflict.border": null,
          "created": null,
          "created.background": null,
          "created.border": null,
          "deleted": null,
          "deleted.background": null,
          "deleted.border": null,
          "error": null,
          "error.background": null,
          "error.border": null,
          "hidden": "#ccccc7",
          "hidden.background": null,
          "hidden.border": null,
          "hint": "#969696ff",
          "hint.background": null,
          "hint.border": null,
          "ignored": null,
          "ignored.background": null,
          "ignored.border": null,
          "info": null,
          "info.background": null,
          "info.border": null,
          "modified": "#a6e22e",
          "modified.background": null,
          "modified.border": null,
          "predictive": null,
          "predictive.background": null,
          "predictive.border": null,
          "renamed": null,
          "renamed.background": null,
          "renamed.border": null,
          "success": null,
          "success.background": null,
          "success.border": null,
          "unreachable": null,
          "unreachable.background": null,
          "unreachable.border": null,
          "warning": null,
          "warning.background": null,
          "warning.border": null,
          "players": [
            {
              "cursor": "#fff",
              "background": null,
              "selection": "#43007375"
            }
          ],
          "syntax": {
            "attribute": {
              "color": "#71c5a9",
              "font_style": null,
              "font_weight": null
            },
            "boolean": {
              "color": "#71c5a9",
              "font_style": null,
              "font_weight": null
            },
            "comment": {
              "color": "#666",
              "font_style": null,
              "font_weight": 500
            },
            "comment.doc": {
              "color": "#sss", # Note: "#sss" is invalid. It should be a valid hex color.
              "font_style": null,
              "font_weight": null
            },
            "constant": {
              "color": "#71c5a9",
              "font_style": null,
              "font_weight": 700
            },
            "constructor": {
              "color": "#9b29ad",
              "font_style": null,
              "font_weight": 200
            },
            "embedded": {
              "color": null,
              "font_style": null,
              "font_weight": null
            },
            "emphasis": {
              "color": null,
              "font_style": null,
              "font_weight": null
            },
            "emphasis.strong": {
              "color": null,
              "font_style": null,
              "font_weight": null
            },
            "enum": {
              "color": null,
              "font_style": null,
              "font_weight": null
            },
            "function": {
              "color": "#73ade9",
              "font_style": null,
              "font_weight": null
            },
            "hint": {
              "color": null,
              "font_style": null,
              "font_weight": null
            },
            "keyword": {
              "color": "#cf7676",
              "font_style": null,
              "font_weight": 400
            },
            "label": {
              "color": null,
              "font_style": null,
              "font_weight": null
            },
            "link_text": {
              "color": null,
              "font_style": null,
              "font_weight": null
            },
            "link_uri": {
              "color": null,
              "font_style": null,
              "font_weight": null
            },
            "number": {
              "color": "#71c5a9",
              "font_style": null,
              "font_weight": 700
            },
            "operator": {
              "color": "#bbb",
              "font_style": null,
              "font_weight": 600
            },
            "predictive": {
              "color": "#5a6a87",
              "font_style": "italic",
              "font_weight": null
            },
            "preproc": {
              "color": null,
              "font_style": null,
              "font_weight": null
            },
            "primary": {
              "color": null,
              "font_style": null,
              "font_weight": null
            },
            "property": {
              "color": "#ac84f6",
              "font_style": null,
              "font_weight": null
            },
            "punctuation": {
              "color": "#acb2be",
              "font_style": null,
              "font_weight": null
            },
            "punctuation.bracket": {
              "color": "#ffcf00",
              "font_style": null,
              "font_weight": 700
            },
            "punctuation.delimiter": {
              "color": "#ff3e56",
              "font_style": null,
              "font_weight": 800
            },
            "punctuation.list_marker": {
              "color": null,
              "font_style": null,
              "font_weight": null
            },
            "punctuation.special": {
              "color": "#c00",
              "font_style": null,
              "font_weight": null
            },
            "string": {
              "color": "#6eae0f",
              "font_style": null,
              "font_weight": 200
            },
            "string.escape": {
              "color": null,
              "font_style": null,
              "font_weight": null
            },
            "string.regex": {
              "color": null,
              "font_style": null,
              "font_weight": null
            },
            "string.special": {
              "color": null,
              "font_style": null,
              "font_weight": null
            },
            "string.special.symbol": {
              "color": null,
              "font_style": null,
              "font_weight": null
            },
            "tag": {
              "color": "#e67c7c",
              "font_style": null,
              "font_weight": null
            },
            "text.literal": {
              "color": null,
              "font_style": null,
              "font_weight": null
            },
            "title": {
              "color": null,
              "font_style": null,
              "font_weight": null
            },
            "type": {
              "color": "#6eb4bf",
              "font_style": null,
              "font_weight": 200
            },
            "variable": {
              "color": "#6a49aa",
              "font_style": "normal",
              "font_weight": 600
            },
            "variable.special": {
              "color": "#b500ff",
              "font_style": null,
              "font_weight": 700
            },
            "variant": {
              "color": null,
              "font_style": null,
              "font_weight": null
            }
          }
        }
      }
    ],
    "id": "2KMYUUvH3eFhS-JOUu_Xz"
  }
  '';

  # Configure Datasette LLM aliases
  home.file."Library/Application Support/io.datasette.llm/aliases.json".text = ''
    {
        "l1": "llama3.2:1b",
        "l3": "llama3.2:3b",
        "hku": "claude-3-haiku-20240307",
        "f": "gemini-1.5-flash-002",
        "fd": "gemini-1.5-flash-8b-latest",
        "fo1": "openrouter/google/gemini-2.0-flash-thinking-exp:free",
        "ds": "openrouter/deepseek/deepseek-chat"
    }
  '';



  # Configure default model for Datasette LLM
  home.file."Library/Application Support/io.datasette.llm/default_model.txt".text = ''
    gemini-1.5-flash-8b-latest
  '';

  # Configure Git commit message template
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
