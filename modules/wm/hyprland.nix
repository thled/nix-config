{ pkgs, ... }: {
  hardware = {
    nvidia = {
      # powerManagement.enable = true;
      modesetting.enable = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
    opengl.enable = true;
  };

  programs.hyprland.enable = true;
  # hint electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment = {
    etc."config/hypr/hyprland.conf".source = ./hyprland.conf;
    etc."config/hypr/hypridle.conf".source = ./hypridle.conf;
    systemPackages = with pkgs; [ 
      fuzzel
      ironbar
      hypridle
      waylock
      wl-clipboard
      wlr-randr
    ];
  };

  security.pam.services.waylock = {};
}

