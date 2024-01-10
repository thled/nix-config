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

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    deviceSection = ''
    Option "DRI" "1"
    '';
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
    xkbOptions = "compose:menu";
    windowManager.leftwm = {
      enable = true;
    };
    displayManager = {
      startx.enable = true;
      defaultSession = "none+leftwm";
      lightdm.enable = true;
      autoLogin = {
        enable = true;
        user = "thled";
      };
    };
  };

  environment = {
    etc."config/leftwm/config.ron".source = ./leftwm.ron;
    etc."config/leftwm/themes/current".source = ./leftwm/theme;
    systemPackages = with pkgs; [
      j4-dmenu-desktop
    ];
  };

  programs.slock.enable = true;
  services.picom.enable = true;
}

