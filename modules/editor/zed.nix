{pkgs, ...}: {
  environment = {
    systemPackages = [pkgs.zed-editor];
    etc."config/zed/settings.json".text =
      #json
      ''
        // Optimized for reviewing Git changes rather than writing code.
        {
          "buffer_font_weight": 400.0,
          "buffer_font_family": "Iosevka Term",
          "buffer_font_size": 16.0,
          "ui_font_size": 16,
          "theme": {
            "mode": "dark",
            "light": "Gruvbox Light",
            "dark": "Gruvbox Dark",
          },

          "diff_view_style": "split",
          "word_diff_enabled": true,
          "format_on_save": "off",
          "autosave": "off",
          "remove_trailing_whitespace_on_save": false,
          "ensure_final_newline_on_save": false,
          "show_completions_on_input": false,
          "inline_code_actions": false,
          "inlay_hints": {
            "enabled": false,
          },

          "disable_ai": true,
          "edit_predictions": {
            "provider": "none",
          },
          "show_edit_predictions": false,
          "agent": {
            "enabled": false,
            "button": false,
          },

          "telemetry": {
            "metrics": false,
            "diagnostics": false,
          },

          "enable_language_server": true,
          "global_lsp_settings": {
            "button": true,
          },
          "load_direnv": "direct",

          "file_scan_exclusions": [
            "**/.direnv",
            "...",
          ],

          "auto_install_extensions": {
            "html": true,
            "php": true,
          },
          "languages": {
            "PHP": {
              "language_servers": ["intelephense"],
              "format_on_save": "off",
              "show_completions_on_input": false,
            },
          },
          "lsp": {
            "intelephense": {
              "settings": {
                "files": {
                  "exclude": ["**/.direnv/**"],
                },
              },
            },
          },

          "git_panel": {
            "button": true,
            "starts_open": true,
            "tree_view": true,
            "show_count_badge": true,
            "entry_primary_click_action": "project_diff",
          },
          "git": {
            "diff_base": "head",
            "git_gutter": "tracked_files",
            "inline_blame": {
              "enabled": false,
            },
          },
          "scrollbar": {
            "git_diff": true,
            "diagnostics": "all",
          },
          "tabs": {
            "show_diagnostics": "all",
          },
          "collaboration_panel": {
            "button": false,
          },
        }
      '';
  };
}
