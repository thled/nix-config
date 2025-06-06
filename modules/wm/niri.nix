{ pkgs, ...}: {
  programs = {
     niri.enable = true;
    waybar.enable = true;
     };

  environment = {
    systemPackages = with pkgs; [
        swaylock
        swayidle
      swaybg
    ];
    etc = {
    "config/waybar/config".source = ./waybar.jsonc;
    "config/waybar/style.css".source = ./waybar.css;
    "config/niri/config.kdl".text = #kdl
    ''
      output "HDMI-A-1" {
        // mode "3840x2160@120.000" TODO check if 120hz is used by default
        mode "3840x2160"
        scale 2
      }

      spawn-at-startup "swaybg" "-i" "~/wallpaper.png" "-m" "fill"
      spawn-at-startup "waybar"
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
      }

      animations {
        // off
        // slowdown 3.0
      }

      screenshot-path "~/screenshots/%Y-%m-%d_%H-%M-%S.png"

      // TODO block out windows from screencapture

      binds {
        Mod+Return { spawn "ghostty"; }
        Mod+P { spawn "fuzzel"; }
        Mod+L { spawn "swaylock" "-f" "-c" "000000"; }
        Mod+V { spawn "sh" "-c" "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"; }
        // Mod+S { spawn "sh" "-c" "slurp | grim -g - - | satty --filename - --fullscreen --output-filename ~/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"; }
        Mod+S { spawn "screenshot"; }
        Mod+D { spawn "brightness-toggle"; }
        Mod+T { toggle-window-floating; }
      }
    '';
  };};
}
