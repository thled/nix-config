{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment = {
    etc."config/hypr/hyprland.conf".source = ./hyprland.conf;
    etc."config/hypr/hypridle.conf".source = ./hypridle.conf;
    etc."config/hypr/hyprlock.conf".source = ./hyprlock.conf;
    etc."config/waybar/config".source = ./waybar.jsonc;
    etc."config/waybar/style.css".source = ./waybar.css;
    systemPackages = with pkgs; [ 
      bibata-cursors
      fuzzel
      hypridle
      hyprlock
      kdePackages.qtwayland
      kdePackages.qt6ct
      libsForQt5.qt5.qtwayland
      libsForQt5.qt5ct
      waybar
      wl-clipboard
      wlr-randr
      xdg-desktop-portal-gtk
    ];
  };

  security = {
    # authentication agent
    polkit.enable = true;
  };  
}

