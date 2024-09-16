{ pkgs, ... }: {
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  environment = {
    etc."config/sway/config".source = ./sway.conf;
    etc."config/waybar/config".source = ./waybar.jsonc;
    etc."config/waybar/style.css".source = ./waybar.css;
    systemPackages = with pkgs; [ 
      autotiling
      # bibata-cursors
      fuzzel
      kdePackages.qtwayland
      kdePackages.qt6ct
      libsForQt5.qt5.qtwayland
      libsForQt5.qt5ct
      waybar
    ];
    variables = {
      GTK_THEME = "Adwaita:dark";
      MOZ_ENABLE_WAYLAND = 1;
      NIXOS_OZONE_WL = 1;
      QT_AUTO_SCREEN_SCALE_FACTOR = 1;
      QT_QPA_PLATFORMTHEME = "qt6ct";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_DESKTOP = "sway";
      XDG_SESSION_TYPE = "wayland";
      # WLR_NO_HARDWARE_CURSORS = 1;
    };
  };
}
