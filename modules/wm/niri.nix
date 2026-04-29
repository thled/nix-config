{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.thled.niri;
in {
  options.thled.niri = {
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Host-specific additions to the shared Niri configuration.";
    };
  };

  config = {
    programs = {
      niri.enable = true;
      waybar.enable = true;
    };

    environment = {
      systemPackages = with pkgs; [
        nautilus
        swaylock
        swayidle
        swaybg
        xwayland-satellite
      ];
      etc = {
        "config/waybar/config".source = ./waybar.jsonc;
        "config/waybar/style.css".source = ./waybar.css;
        "config/niri/config.kdl".text =
          #kdl
          ''
              ${lib.optionalString (cfg.extraConfig != "") "${cfg.extraConfig}\n"}
              spawn-at-startup "swaybg" "-i" "/home/thled/wallpaper.png" "-m" "fill"
              spawn-at-startup "sh" "-c" "pkill mako; mako"
              spawn-at-startup "sh" "-c" "pkill wl-paste; wl-paste --type text --watch cliphist store"
              spawn-at-startup "sh" "-c" "swayidle -w timeout 600 'swaylock -f -c 000000' timeout 800 'niri msg action power-off-monitors' resume 'niri msg action power-off-monitors' before-sleep 'swaylock -f -c 000000'"

            input {
              keyboard {
                xkb {
                  layout "us"
                  options "compose:menu"
                }
              }
              touchpad {
                natural-scroll
              }
              mouse {
                natural-scroll
              }
            }

            cursor {
              xcursor-theme "Bibata-Modern-Classic"
              xcursor-size 16
              hide-after-inactive-ms 10000
            }

            layout {
              gaps 0

              center-focused-column "on-overflow"
              always-center-single-column
              empty-workspace-above-first

              preset-column-widths {
                proportion 0.5
                proportion 0.66667
                proportion 0.25
              }

              default-column-width { proportion 1.0; }

              focus-ring {
                off
                width 2

                active-color "#7fc8ff"
                inactive-color "#505050"
              }

              border {
                width 1
                inactive-color "#505050"
                urgent-color "#9b0000"

                active-gradient from="#33ccffee" to="#00ff99ee" angle=135 relative-to="workspace-view"
              }
            }

            animations {
              // off
              // slowdown 3.0
            }

            overview {
              zoom 0.25
            }

            environment {
              ELECTRON_OZONE_PLATFORM_HINT "auto"
              NIXOS_OZONE_WL "1"
            }

            screenshot-path "~/screenshots/%Y-%m-%d_%H-%M-%S.png"
            prefer-no-csd

            layer-rule {
              match namespace="^notifications$"
              match namespace="^launcher$"

              block-out-from "screencast"
            }

            window-rule {
              match app-id="chrome-cifhbcnohmdccbgoicgdjpfamggdegmo-Default" // Teams
              match app-id="com.mitchellh.ghostty"
              match app-id=".mindwtr-wrapped_"

              default-column-width { proportion 0.5; }
            }

            window-rule {
              match app-id="org.gnome.Nautilus"
              match app-id="com.gabm.satty"

              open-floating true
            }

            window-rule {
              match app-id="chrome-cifhbcnohmdccbgoicgdjpfamggdegmo-Default" // Teams
              match app-id="com.obsproject.Studio"
              match app-id="obsidian"
              match app-id="org.gnome.Nautilus"
              match app-id="vesktop"
              match app-id="zen" title="- Gmail "
              match app-id="zen" title="- TickTick "
              match app-id=".mindwtr-wrapped_"
              exclude is-window-cast-target=true

              block-out-from "screencast"
            }

            window-rule {
                match is-window-cast-target=true

                border {
                    active-color "#f38ba8"
                    inactive-color "#7d0d2d"
                }
            }

            hotkey-overlay {
              skip-at-startup
            }

            binds {
              // Default bindings
              Mod+Shift+Slash    { show-hotkey-overlay; } // same as Mod-?
              Mod+O repeat=false { toggle-overview; } // or top-left hot corner
              Mod+Q              { close-window; }

              Mod+Home      { focus-column-first; }
              Mod+End       { focus-column-last; }
              Mod+Ctrl+Home { move-column-to-first; }
              Mod+Ctrl+End  { move-column-to-last; }

              Mod+Shift+Left  { focus-monitor-left; }
              Mod+Shift+Right { focus-monitor-right; }

              Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
              Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
              Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
              Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }

              Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
              Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
              Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
              Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

              Mod+WheelScrollRight           { focus-column-right; }
              Mod+WheelScrollLeft            { focus-column-left; }
              Mod+Ctrl+WheelScrollRight      { move-column-right; }
              Mod+Ctrl+WheelScrollLeft       { move-column-left; }
              Mod+Shift+WheelScrollDown      { focus-column-right; }
              Mod+Shift+WheelScrollUp        { focus-column-left; }
              Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
              Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

              Mod+1      { focus-workspace 1; }
              Mod+2      { focus-workspace 2; }
              Mod+3      { focus-workspace 3; }
              Mod+4      { focus-workspace 4; }
              Mod+5      { focus-workspace 5; }
              Mod+6      { focus-workspace 6; }
              Mod+7      { focus-workspace 7; }
              Mod+8      { focus-workspace 8; }
              Mod+9      { focus-workspace 9; }
              Mod+Ctrl+1 { move-column-to-workspace 1; }
              Mod+Ctrl+2 { move-column-to-workspace 2; }
              Mod+Ctrl+3 { move-column-to-workspace 3; }
              Mod+Ctrl+4 { move-column-to-workspace 4; }
              Mod+Ctrl+5 { move-column-to-workspace 5; }
              Mod+Ctrl+6 { move-column-to-workspace 6; }
              Mod+Ctrl+7 { move-column-to-workspace 7; }
              Mod+Ctrl+8 { move-column-to-workspace 8; }
              Mod+Ctrl+9 { move-column-to-workspace 9; }

              Mod+Tab { focus-workspace-previous; }

              Mod+BracketLeft  { consume-or-expel-window-left; }
              Mod+BracketRight { consume-or-expel-window-right; }
              Mod+Comma        { consume-window-into-column; }
              Mod+Period       { expel-window-from-column; }

              Mod+R       { switch-preset-column-width; }
              Mod+Shift+R { switch-preset-window-height; }
              Mod+Ctrl+R  { reset-window-height; }
              Mod+F       { maximize-column; }
              Mod+Shift+F { fullscreen-window; }

              Mod+Ctrl+F { expand-column-to-available-width; }

              Mod+C      { center-column; }
              Mod+Ctrl+C { center-visible-columns; }

              Mod+Minus       { set-column-width "-10%"; }
              Mod+Plus        { set-column-width "+10%"; }
              Mod+Shift+Minus { set-window-height "-10%"; }
              Mod+Shift+Plus  { set-window-height "+10%"; }

              Mod+W { toggle-column-tabbed-display; }

              Print      { screenshot; }
              Ctrl+Print { screenshot-screen; }
              Alt+Print  { screenshot-window; }

              Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }

              Ctrl+Alt+Delete { quit; }
              Mod+Shift+P     { power-off-monitors; }

              // Custom bindings
              Mod+Left       { focus-column-left-or-last; }
              Mod+Right      { focus-column-right-or-first; }
              Mod+Down       { focus-window-or-workspace-down; }
              Mod+Up         { focus-window-or-workspace-up; }
              Mod+Ctrl+Left  { move-column-left; }
              Mod+Ctrl+Right { move-column-right; }
              Mod+Ctrl+Down  { move-window-down-or-to-workspace-down; }
              Mod+Ctrl+Up    { move-window-up-or-to-workspace-up; }
              Mod+Shift+Down { move-workspace-down; }
              Mod+Shift+Up   { move-workspace-up; }

              Mod+H       { focus-column-left-or-last; }
              Mod+I       { focus-column-right-or-first; }
              Mod+A       { focus-window-or-workspace-down; }
              Mod+E       { focus-window-or-workspace-up; }
              Mod+Ctrl+H  { move-column-left; }
              Mod+Ctrl+I  { move-column-right; }
              Mod+Ctrl+A  { move-window-down-or-to-workspace-down; }
              Mod+Ctrl+E  { move-window-up-or-to-workspace-up; }
              Mod+Shift+A { move-workspace-down; }
              Mod+Shift+E { move-workspace-up; }

              Mod+Return hotkey-overlay-title="Open Terminal" { spawn "ghostty"; }
              Mod+P hotkey-overlay-title="Open Launcher"      { spawn "fuzzel"; }
              Mod+L hotkey-overlay-title="Lock"               { spawn "swaylock" "-f" "-c" "000000"; }

              Mod+Space hotkey-overlay-title="Mindwtr Capture"    { spawn "mindwtr-capture"; }
              Mod+V hotkey-overlay-title="Open Clipboard history" { spawn "sh" "-c" "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"; }

              Mod+S       { screenshot; }
              Mod+Shift+S { spawn "sh" "-c" "wl-paste | satty --filename - --output-filename ~/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"; }

              Mod+T       { toggle-window-floating; }
              Mod+Shift+T { switch-focus-between-floating-and-tiling; }

              Mod+G       { set-dynamic-cast-window; }
              Mod+Shift+G { clear-dynamic-cast-target; }
            }
          '';
      };
    };
  };
}
