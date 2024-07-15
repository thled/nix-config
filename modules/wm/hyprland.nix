{ pkgs, ... }: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        # Option A: Offload Mode
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        # Option B: Sync Mode
        # sync.enable = true;

        # Option C: Reverse Sync Mode
        # reverseSync.enable = true;
        # allowExternalGpu = false;

        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";

        # allowExternalGpu = true;
      };
      powerManagement.enable = false;
    };
    graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [nvidia-vaapi-driver intel-media-driver];
        extraPackages32 = with pkgs.pkgsi686Linux; [nvidia-vaapi-driver intel-media-driver];
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment = {
    etc."config/hypr/hyprland.conf".source = ./hyprland.conf;
    etc."config/hypr/hypridle.conf".source = ./hypridle.conf;
    etc."config/waybar/config".source = ./waybar.jsonc;
    etc."config/waybar/style.css".source = ./waybar.css;
    systemPackages = with pkgs; [ 
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
    # make waylock work
    # pam.services.waylock = {};
    # authentication agent
    polkit.enable = true;
  };  
}

