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
      light = "Rosé Pine Dawn";
      dark = "Vintergata";
    };
    buffer_font_family = "JetBrains Mono";
    features = {
      edit_prediction_provider = "supermaven";
    };

    assistant = {
      enabled = true;
      version = "2";
      button = true;
      dock = "right";
      default_model = {
        provider = "openai";
        model = "google/gemini-2.0-flash-001";
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
            name = "deepseek/deepseek-r1:floor";
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
          {
            name = "anthropic/claude-3.7-sonnet:thinking";
            display_name = "Claude 3.7 Sonnet Thinking";
            max_tokens = 200000;
          }
          {
            name = "anthropic/claude-3.7-sonnet";
            display_name = "Claude 3.7 Sonnet";
            max_tokens = 200000;
          }
          {
            name = "qwen/qwq-32b:nitro";
            display_name = "Qwen QvQ 32b";
            max_tokens = 131000;
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
  home.file.".config/zed/themes/purr_light.json".text = ''
    {
      "$schema": "https://zed.dev/schema/themes/v0.1.0.json",
      "name": "Purr",
      "author": "Ryuu <me@ryuu.gg>",
      "themes": [
        {
          "name": "Purr Light",
          "appearance": "light",
          "style": {
            "background": "#FFFFFF",
            "border": "#E8E9EC",
            "border.variant": "#E4E6E8",
            "border.focused": "#D8DADC",
            "border.selected": "#E4E6E8",
            "border.transparent": "#E4E6E8",
            "border.disabled": "#ACB0BE",
            "editor.background": "#FFFFFF",
            "editor.foreground": "#4C4F69",
            "editor.line_number": "#8C8FA1",
            "editor.active_line_number": "#4C4F69",
            "editor.active_line.background": "#4C4F690A",
            "editor.gutter.background": "#FFFFFF",
            "editor.wrap_guide": "#E8E9EC",
            "editor.active_wrap_guide": "#E8E9EC",
            "editor.document_highlight.read_background": "#4C4F6915",
            "editor.document_highlight.write_background": "#4C4F6915",
            "editor.subheader.background": "#FFFFFF",
            "editor.highlighted_line.background": null,
            "editor.invisible": "#7C7F9366",
            "element.background": "#FFFFFF08",
            "element.hover": "#30334020",
            "element.active": "#30334020",
            "element.selected": "#30334020",
            "element.disabled": "#ACB0BE",
            "ghost_element.background": null,
            "ghost_element.hover": "#30334015",
            "ghost_element.active": "#30334015",
            "ghost_element.selected": "#30334015",
            "ghost_element.disabled": "#ACB0BE",
            "text": "#4C4F69",
            "text.muted": "#5C5F77",
            "text.placeholder": "#ACB0BE",
            "text.disabled": "#ACB0BE",
            "text.accent": "#2D74E4",
            "icon": "#4C4F69",
            "icon.muted": "#8C8FA1",
            "icon.disabled": "#ACB0BE",
            "icon.placeholder": "#ACB0BE",
            "icon.accent": "#2D74E4",
            "link_text.hover": "#2D74E4",
            "surface.background": "#FFFFFF",
            "elevated_surface.background": "#FFFFFF",
            "drop_target.background": "#8839EF40",
            "status_bar.background": "#FFFFFF",
            "title_bar.background": "#FFFFFF",
            "title_bar.inactive_background": "#FFFFFFD9",
            "toolbar.background": "#FFFFFF",
            "tab_bar.background": "#FFFFFF",
            "tab.active_background": "#FFFFFF",
            "tab.inactive_background": "#F8F9FB",
            "panel.background": "#FFFFFF",
            "panel.focused_border": "#4C4F69",
            "pane.focused_border": "#4C4F69",
            "search.match_background": "#4C4F6920",
            "scrollbar.track.background": "#FFFFFF",
            "scrollbar.track.border": "#D20F3910",
            "scrollbar.thumb.background": "#D20F3920",
            "scrollbar.thumb.border": "#8839EF10",
            "scrollbar.thumb.hover_background": "#D20F3940",
            "terminal.background": "#FFFFFF",
            "terminal.foreground": "#4C4F69",
            "terminal.dim_foreground": "#8C8FA1",
            "terminal.bright_foreground": "#4C4F69",
            "terminal.ansi.black": "#000000",
            "terminal.ansi.red": "#D0679D",
            "terminal.ansi.green": "#1F9B79",
            "terminal.ansi.yellow": "#DF8E1D",
            "terminal.ansi.blue": "#2D74E4",
            "terminal.ansi.magenta": "#D0679D",
            "terminal.ansi.cyan": "#209FB5",
            "terminal.ansi.white": "#4C4F69",
            "terminal.ansi.bright_black": "#767C9D",
            "terminal.ansi.bright_red": "#D0679D",
            "terminal.ansi.bright_green": "#2AAA8A",
            "terminal.ansi.bright_yellow": "#DF8E1D",
            "terminal.ansi.bright_blue": "#2D74E4",
            "terminal.ansi.bright_magenta": "#D0679D",
            "terminal.ansi.bright_cyan": "#209FB5",
            "terminal.ansi.bright_white": "#4C4F69",
            "terminal.ansi.dim_black": "#767C9D",
            "terminal.ansi.dim_red": "#D0679D",
            "terminal.ansi.dim_green": "#1F9B79",
            "terminal.ansi.dim_yellow": "#DF8E1D",
            "terminal.ansi.dim_blue": "#2D74E4",
            "terminal.ansi.dim_magenta": "#D0679D",
            "terminal.ansi.dim_cyan": "#209FB5",
            "terminal.ansi.dim_white": "#5C5F77",
            "error": "#D20F39",
            "error.border": "#D20F39",
            "error.background": "#FFFFFF",
            "warning": "#DF8E1D",
            "warning.border": "#DF8E1D",
            "warning.background": "#FFFFFF",
            "info": "#209FB5",
            "info.border": "#209FB5",
            "info.background": "#D20F3915",
            "success": "#40A02B",
            "success.border": "#40A02B",
            "success.background": "#FFFFFF",
            "modified": "#2D74E4",
            "modified.border": "#2D74E4",
            "modified.background": "#FFFFFF",
            "created": "#40A02B",
            "created.border": "#40A02B",
            "created.background": "#FFFFFF",
            "deleted": "#D20F39",
            "deleted.border": "#D20F39",
            "deleted.background": "#FFFFFF",
            "unreachable": "#D20F39",
            "unreachable.border": "#D20F39",
            "unreachable.background": "#FFFFFF",
            "hidden": "#ACB0BE",
            "hidden.border": "#ACB0BE",
            "hidden.background": "#FFFFFF",
            "ignored": "#ACB0BE",
            "ignored.border": "#ACB0BE",
            "ignored.background": "#FFFFFF",
            "renamed": "#2D74E4",
            "renamed.border": "#2D74E4",
            "renamed.background": "#FFFFFF",
            "predictive": "#2D74E4",
            "predictive.border": "#2D74E4",
            "predictive.background": "#FFFFFF",
            "hint": "#209FB5",
            "hint.border": "#ACB0BE",
            "hint.background": "#FFFFFF",
            "syntax": {
              "keyword": {
                "color": "#D20F39"
              },
              "variable": {
                "color": "#4C4F69"
              },
              "variable.member": {
                "color": "#4C4F69"
              },
              "variable.parameter": {
                "color": "#D20F39",
                "font_style": "italic"
              },
              "variable.special": {
                "color": "#D20F39",
                "font_style": "italic"
              },
              "function": {
                "color": "#2D74E4",
                "font_style": "italic"
              },
              "type": {
                "color": "#DF8E1D"
              },
              "type.interface": {
                "color": "#DF8E1D"
              },
              "type.super": {
                "color": "#DF8E1D"
              },
              "constant": {
                "color": "#D20F39"
              },
              "string": {
                "color": "#40A02B"
              },
              "number": {
                "color": "#D20F39"
              },
              "boolean": {
                "color": "#D20F39"
              },
              "comment": {
                "color": "#8C8FA1",
                "font_style": "italic"
              },
              "comment.doc": {
                "color": "#8C8FA1",
                "font_style": "italic"
              },
              "operator": {
                "color": "#209FB5"
              },
              "property": {
                "color": "#2D74E4"
              },
              "tag": {
                "color": "#2D74E4"
              },
              "attribute": {
                "color": "#DF8E1D"
              },
              "embedded": {
                "color": "#D20F39"
              },
              "emphasis": {
                "color": "#D20F39",
                "font_style": "italic"
              },
              "emphasis.strong": {
                "color": "#D20F39",
                "font_weight": 700
              },
              "enum": {
                "color": "#209FB5",
                "font_weight": 700
              },
              "link_text": {
                "color": "#2D74E4"
              },
              "link_uri": {
                "color": "#2D74E4"
              },
              "predoc": {
                "color": "#D20F39"
              },
              "primary": {
                "color": "#D20F39"
              },
              "punctuation": {
                "color": "#209FB5"
              },
              "punctuation.bracket": {
                "color": "#209FB5"
              },
              "punctuation.delimiter": {
                "color": "#8C8FA1"
              },
              "punctuation.list_marker": {
                "color": "#209FB5"
              },
              "punctuation.special": {
                "color": "#209FB5"
              },
              "punctuation.special.symbol": {
                "color": "#D20F39"
              },
              "string.escape": {
                "color": "#D20F39"
              },
              "string.regex": {
                "color": "#D20F39"
              },
              "string.special": {
                "color": "#D20F39"
              },
              "string.special.symbol": {
                "color": "#D20F39"
              },
              "text.literal": {
                "color": "#40A02B"
              },
              "title": {
                "color": "#4C4F69",
                "font_weight": 800
              },
              "variant": {
                "color": "#D20F39"
              }
            },
            "players": [
              {
                "cursor": "#4C4F69",
                "selection": "#4C4F6915",
                "background": "#4C4F69"
              },
              {
                "cursor": "#2D74E4",
                "selection": "#2D74E433",
                "background": "#2D74E4"
              },
              {
                "cursor": "#D20F39",
                "selection": "#D20F3933",
                "background": "#D20F39"
              },
              {
                "cursor": "#209FB5",
                "selection": "#209FB533",
                "background": "#209FB5"
              },
              {
                "cursor": "#DF8E1D",
                "selection": "#DF8E1D33",
                "background": "#DF8E1D"
              },
              {
                "cursor": "#40A02B",
                "selection": "#40A02B33",
                "background": "#40A02B"
              }
            ]
          }
        },
        {
          "name": "Purr Dark",
          "appearance": "dark",
          "style": {
            "background": "#000000",
            "border": "#FFFFFF10",
            "border.variant": "#303340",
            "border.focused": "#E4F0FB",
            "border.selected": "#ADD7FF",
            "border.disabled": "#767C9D",
            "border.transparent": "#00000000",
            "editor.background": "#000000",
            "editor.foreground": "#E4F0FB",
            "editor.line_number": "#767C9D50",
            "editor.active_line_number": "#E4F0FB",
            "editor.active_line.background": "#717CB425",
            "editor.gutter.background": "#000000",
            "editor.wrap_guide": "#E4F0FB10",
            "editor.active_wrap_guide": "#303340",
            "editor.document_highlight.read_background": "#ADD7FF20",
            "editor.document_highlight.write_background": "#ADD7FF40",
            "editor.subheader.background": "#000000",
            "editor.highlighted_line.background": null,
            "editor.invisible": "#767C9D66",
            "element.background": "#FFFFFF08",
            "element.hover": "#303340CC",
            "element.active": "#303340CC",
            "element.selected": "#303340CC",
            "element.disabled": "#303340",
            "ghost_element.background": "#00000000",
            "ghost_element.hover": "#30334080",
            "ghost_element.active": "#30334080",
            "ghost_element.selected": "#30334080",
            "ghost_element.disabled": "#303340",
            "text": "#E4F0FB",
            "text.muted": "#A6ACCD",
            "text.placeholder": "#E4F0FB60",
            "text.accent": "#89DDFF",
            "text.disabled": "#767C9D",
            "icon": "#E4F0FB",
            "icon.muted": "#A6ACCD",
            "icon.disabled": "#767C9D",
            "icon.accent": "#89DDFF",
            "icon.placeholder": "#E4F0FB60",
            "link_text.hover": "#89DDFF",
            "surface.background": "#000000",
            "elevated_surface.background": "#000000",
            "drop_target.background": "#ADD7FF66",
            "status_bar.background": "#000000",
            "title_bar.background": "#000000",
            "title_bar.inactive_background": "#000000D9",
            "toolbar.background": "#000000",
            "tab_bar.background": "#000000",
            "tab.active_background": "#000000",
            "tab.inactive_background": "#000000",
            "panel.background": "#000000",
            "panel.focused_border": "#E4F0FB",
            "pane.focused_border": "#E4F0FB",
            "search.match_background": "#ADD7FF40",
            "scrollbar.track.background": "#00000080",
            "scrollbar.track.border": "#00000000",
            "scrollbar_thumb.background": "#E4F0FB25",
            "scrollbar.thumb.border": "#00000000",
            "scrollbar.thumb.hover_background": "#E4F0FB40",
            "terminal.background": "#000000",
            "terminal.foreground": "#E4F0FB",
            "terminal.dim_foreground": "#767C9D",
            "terminal.bright_foreground": "#E4F0FB",
            "terminal.ansi.black": "#000000",
            "terminal.ansi.red": "#D0679D",
            "terminal.ansi.green": "#5DE4C7",
            "terminal.ansi.yellow": "#FFFAC2",
            "terminal.ansi.blue": "#89DDFF",
            "terminal.ansi.magenta": "#F087BD",
            "terminal.ansi.cyan": "#89DDFF",
            "terminal.ansi.white": "#FFFFFF",
            "terminal.ansi.bright_black": "#767C9D",
            "terminal.ansi.bright_red": "#D0679D",
            "terminal.ansi.bright_green": "#5DE4C7",
            "terminal.ansi.bright_yellow": "#FFFAC2",
            "terminal.ansi.bright_blue": "#ADD7FF",
            "terminal.ansi.bright_magenta": "#F087BD",
            "terminal.ansi.bright_cyan": "#ADD7FF",
            "terminal.ansi.bright_white": "#FFFFFF",
            "terminal.ansi.dim_black": "#767C9D",
            "terminal.ansi.dim_red": "#D0679D",
            "terminal.ansi.dim_green": "#5DE4C7",
            "terminal.ansi.dim_yellow": "#FFFAC2",
            "terminal.ansi.dim_blue": "#89DDFF",
            "terminal.ansi.dim_magenta": "#F087BD",
            "terminal.ansi.dim_cyan": "#89DDFF",
            "terminal.ansi.dim_white": "#A6ACCD",
            "error": "#D0679D",
            "error.background": "#D0679D20",
            "error.border": "#D0679D",
            "warning": "#FFFAC2",
            "warning.background": "#FFFAC220",
            "warning.border": "#FFFAC2",
            "info": "#ADD7FF",
            "info.background": "#ADD7FF20",
            "info.border": "#ADD7FF",
            "success": "#5DE4C7",
            "success.background": "#5DE4C720",
            "success.border": "#5DE4C7",
            "modified": "#ADD7FF",
            "modified.background": "#ADD7FF20",
            "modified.border": "#ADD7FF",
            "created": "#5DE4C7",
            "created.background": "#5DE4C720",
            "created.border": "#5DE4C7",
            "deleted": "#D0679D",
            "deleted.background": "#D0679D20",
            "deleted.border": "#D0679D",
            "unreachable": "#D0679D",
            "unreachable.border": "#D0679D",
            "unreachable.background": "#000000",
            "hidden": "#767C9D",
            "hidden.border": "#767C9D",
            "hidden.background": "#000000",
            "ignored": "#767C9D",
            "ignored.border": "#767C9D",
            "ignored.background": "#000000",
            "renamed": "#89DDFF",
            "renamed.border": "#89DDFF",
            "renamed.background": "#000000",
            "predictive": "#ADD7FF",
            "predictive.border": "#ADD7FF",
            "predictive.background": "#000000",
            "hint": "#89DDFF",
            "hint.border": "#767C9D",
            "hint.background": "#000000",
            "syntax": {
              "keyword": {
                "color": "#F087BD"
              },
              "variable": {
                "color": "#E4F0FB"
              },
              "variable.member": {
                "color": "#E4F0FB"
              },
              "variable.parameter": {
                "color": "#F087BD",
                "font_style": "italic"
              },
              "variable.special": {
                "color": "#F087BD",
                "font_style": "italic"
              },
              "function": {
                "color": "#ADD7FF",
                "font_style": "italic"
              },
              "type": {
                "color": "#FFFAC2"
              },
              "type.interface": {
                "color": "#FFFAC2"
              },
              "type.super": {
                "color": "#FFFAC2"
              },
              "constant": {
                "color": "#F087BD"
              },
              "string": {
                "color": "#5DE4C7"
              },
              "number": {
                "color": "#F087BD"
              },
              "boolean": {
                "color": "#5DE4C7"
              },
              "comment": {
                "color": "#767C9DB0",
                "font_style": "italic"
              },
              "comment.doc": {
                "color": "#767C9DB0",
                "font_style": "italic"
              },
              "operator": {
                "color": "#89DDFF"
              },
              "property": {
                "color": "#89DDFF"
              },
              "tag": {
                "color": "#F087BD"
              },
              "attribute": {
                "color": "#ADD7FF"
              },
              "embedded": {
                "color": "#F087BD"
              },
              "emphasis": {
                "color": "#F087BD",
                "font_style": "italic"
              },
              "emphasis.strong": {
                "color": "#F087BD",
                "font_weight": 700
              },
              "enum": {
                "color": "#FFFAC2",
                "font_weight": 700
              },
              "link_text": {
                "color": "#89DDFF"
              },
              "link_uri": {
                "color": "#89DDFF"
              },
              "predoc": {
                "color": "#F087BD"
              },
              "primary": {
                "color": "#F087BD"
              },
              "punctuation": {
                "color": "#89DDFF"
              },
              "punctuation.bracket": {
                "color": "#89DDFF"
              },
              "punctuation.delimiter": {
                "color": "#A6ACCD"
              },
              "punctuation.list_marker": {
                "color": "#89DDFF"
              },
              "punctuation.special": {
                "color": "#89DDFF"
              },
              "punctuation.special.symbol": {
                "color": "#F087BD"
              },
              "string.escape": {
                "color": "#F087BD"
              },
              "string.regex": {
                "color": "#F087BD"
              },
              "string.special": {
                "color": "#F087BD"
              },
              "string.special.symbol": {
                "color": "#F087BD"
              },
              "text.literal": {
                "color": "#5DE4C7"
              },
              "title": {
                "color": "#E4F0FB",
                "font_weight": 800
              },
              "variant": {
                "color": "#F087BD"
              }
            },
            "players": [
              {
                "cursor": "#E4F0FB",
                "selection": "#E4F0FB25",
                "background": "#E4F0FB"
              },
              {
                "cursor": "#89DDFF",
                "selection": "#89DDFF33",
                "background": "#89DDFF"
              },
              {
                "cursor": "#F087BD",
                "selection": "#F087BD33",
                "background": "#F087BD"
              },
              {
                "cursor": "#5DE4C7",
                "selection": "#5DE4C733",
                "background": "#5DE4C7"
              },
              {
                "cursor": "#FFFAC2",
                "selection": "#FFFAC233",
                "background": "#FFFAC2"
              },
              {
                "cursor": "#ADD7FF",
                "selection": "#ADD7FF33",
                "background": "#ADD7FF"
              }
            ]
          }
        }
      ]
    }
  '';

  home.file.".config/zed/themes/rose.json".text = ''
    {
      "$schema": "https://zed.dev/schema/themes/v0.1.0.json",
      "name": "Rose",
      "author": "Kainoa Kanter <kainoa@t1c.dev>",
      "themes": [
        {
          "appearance": "light",
          "name": "Rosé Pine Dawn",
          "style": {
            "editor.foreground": "#575279",
            "editor.background": "#faf4ed",
            "editor.gutter.background": "#faf4ed",
            "editor.active_line.background": "#fffaf3",
            "editor.line_number": "#9893a5",
            "editor.active_line_number": "#575279",
            "editor.invisible": "#9893a5",
            "editor.wrap_guide": "#9893a544",
            "editor.active_wrap_guide": "#9893a588",
            "editor.document_highlight.read_background": "#56949f1a",
            "editor.document_highlight.write_background": "#9893a566",
            "editor.subheader.background": "#fffaf3",
            "editor.highlighted_line.background": "#fffaf3",
            "ghost_element.active": "#797593",
            "ghost_element.hover": "#dfdad9",
            "ghost_element.selected": "#cecacd",
            "ghost_element.background": "#f4ede8",
            "border": "#fffaf3",
            "border.variant": "#fffaf3",
            "border.focused": "#fffaf3",
            "border.selected": "#fffaf3",
            "border.transparent": "transparent",
            "border.disabled": "#fffaf3",
            "text": "#575279",
            "text.muted": "#9893a5",
            "text.placeholder": "#9893a5",
            "text.disabled": "#9893a5",
            "text.accent": "#56949f",
            "surface.background": "#fffaf3",
            "elevated_surface.background": "#fffaf3",
            "panel.background": "#faf4ed",
            "panel.focused_border": "#fffaf3",
            "background": "#faf4ed",
            "status_bar.background": "#faf4ed",
            "title_bar.background": "#faf4ed",
            "toolbar.background": "#faf4ed",
            "tab_bar.background": "#fffaf3",
            "tab.inactive_background": "#fffaf3",
            "tab.active_background": "#faf4ed",
            "element.background": "#fffaf3",
            "element.hover": "#f2e9e1",
            "element.active": "#f2e9e1",
            "element.selected": "#cecacd",
            "element.disabled": "#f2e9e1",
            "drop_target.background": "#57527980",
            "predictive": "#797593",
            "modified": "#d7827e",
            "ignored": "#9893a5",
            "deleted": "#b4637a",
            "created": "#56949f",
            "warning": "#ea9d34",
            "warning.background": "#f4ede8",
            "warning.border": "#ea9d34",
            "hint": "#797593",
            "hint.background": "#f4ede8",
            "error": "#b4637a",
            "error.background": "#f4ede8",
            "error.border": "#b4637a",
            "info": "#286983",
            "scrollbar.thumb.background": "#dfdad9",
            "scrollbar.thumb.hover_background": "#fffaf3",
            "scrollbar.thumb.border": "#f4ede8",
            "scrollbar.track.background": "#00000000",
            "scrollbar.track.border": "#f4ede8",
            "terminal.background": "#faf4ed",
            "terminal.foreground": "#575279",
            "terminal.bright_foreground": "#575279",
            "terminal.dim_foreground": "#faf4ed",
            "terminal.ansi.black": "#f4ede8",
            "terminal.ansi.bright_black": "#797593",
            "terminal.ansi.dim_black": "#575279",
            "terminal.ansi.red": "#b4637a",
            "terminal.ansi.bright_red": "#b4637a",
            "terminal.ansi.dim_red": "#b4637a",
            "terminal.ansi.green": "#286983",
            "terminal.ansi.bright_green": "#286983",
            "terminal.ansi.dim_green": "#286983",
            "terminal.ansi.yellow": "#ea9d34",
            "terminal.ansi.bright_yellow": "#ea9d34",
            "terminal.ansi.dim_yellow": "#ea9d34",
            "terminal.ansi.blue": "#56949f",
            "terminal.ansi.bright_blue": "#56949f",
            "terminal.ansi.dim_blue": "#56949f",
            "terminal.ansi.magenta": "#907aa9",
            "terminal.ansi.bright_magenta": "#907aa9",
            "terminal.ansi.dim_magenta": "#907aa9",
            "terminal.ansi.cyan": "#d7827e",
            "terminal.ansi.bright_cyan": "#d7827e",
            "terminal.ansi.dim_cyan": "#d7827e",
            "terminal.ansi.white": "#575279",
            "terminal.ansi.bright_white": "#575279",
            "terminal.ansi.dim_white": "#575279",
            "link_text.hover": "#56949f",
            "conflict": "#ea9d34",
            "conflict.background": "#f4ede8",
            "conflict.border": "#ea9d34",
            "created.background": "#f4ede8",
            "created.border": "#56949f",
            "deleted.background": "#f4ede8",
            "deleted.border": "#b4637a",
            "hidden.background": "#faf4ed",
            "hidden.border": "#fffaf3",
            "ignored.background": "#faf4ed",
            "ignored.border": "#fffaf3",
            "info.background": "#f4ede8",
            "info.border": "#286983",
            "modified.background": "#f4ede8",
            "modified.border": "#d7827e",
            "predictive.background": "#f4ede8",
            "predictive.border": "#286983",
            "renamed.background": "#f4ede8",
            "renamed.border": "#286983",
            "success": "#286983",
            "success.background": "#f4ede8",
            "success.border": "#286983",
            "unreachable": "#797593",
            "unreachable.background": "#faf4ed",
            "unreachable.border": "#fffaf3",
            "players": [
              {
                "cursor": "#575279",
                "background": "#575279",
                "selection": "#57527922"
              },
              {
                "cursor": "#56949f",
                "background": "#56949f",
                "selection": "#56949f44"
              },
              {
                "cursor": "#907aa9",
                "background": "#907aa9",
                "selection": "#907aa944"
              },
              {
                "cursor": "#286983",
                "background": "#286983",
                "selection": "#28698344"
              },
              {
                "cursor": "#b4637a",
                "background": "#b4637a",
                "selection": "#b4637a44"
              }
            ],
            "syntax": {
              "attribute": {
                "color": "#797593"
              },
              "boolean": {
                "color": "#d7827e"
              },
              "comment": {
                "color": "#9893a5",
                "font_style": "italic"
              },
              "comment.doc": {
                "color": "#797593"
              },
              "constant": {
                "color": "#575279"
              },
              "constructor": {
                "color": "#b4637a"
              },
              "embedded": {
                "color": "#575279"
              },
              "emphasis": {
                "color": "#907aa9",
                "font_style": "italic"
              },
              "emphasis.strong": {
                "color": "#56949f",
                "font_weight": 700
              },
              "enum": {
                "color": "#286983"
              },
              "function": {
                "color": "#d7827e"
              },
              "hint": {
                "color": "#907aa9"
              },
              "keyword": {
                "color": "#286983"
              },
              "label": {
                "color": "#d7827e"
              },
              "link_text": {
                "color": "#907aa9"
              },
              "link_uri": {
                "color": "#286983"
              },
              "number": {
                "color": "#56949f"
              },
              "operator": {
                "color": "#797593"
              },
              "predictive": {
                "color": "#797593"
              },
              "preproc": {
                "color": "#ea9d34"
              },
              "primary": {
                "color": "#907aa9"
              },
              "property": {
                "color": "#575279"
              },
              "punctuation": {
                "color": "#797593"
              },
              "punctuation.bracket": {
                "color": "#97495F"
              },
              "punctuation.delimiter": {
                "color": "#797593"
              },
              "punctuation.list_marker": {
                "color": "#797593",
                "font_weight": 700
              },
              "punctuation.special": {
                "color": "#286983"
              },
              "string": {
                "color": "#ea9d34"
              },
              "string.escape": {
                "color": "#ea9d34"
              },
              "string.regex": {
                "color": "#ea9d34"
              },
              "string.special": {
                "color": "#286983"
              },
              "string.special.symbol": {
                "color": "#286983"
              },
              "tag": {
                "color": "#907aa9"
              },
              "text.literal": {
                "color": "#ea9d34"
              },
              "title": {
                "color": "#b4637a",
                "font_weight": 700
              },
              "type": {
                "color": "#56949f"
              },
              "variable": {
                "color": "#575279"
              },
              "variable.special": {
                "color": "#56949f"
              },
              "variant": {
                "color": "#d7827e"
              }
            }
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
    openrouter/google/gemini-2.0-flash-001
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
