{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" ];
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

  environment.etc."config/leftwm/config.ron".source = ./leftwm.ron;
  environment.etc."config/leftwm/themes/current".source = ./leftwm/theme;

  programs.slock.enable = true;
  services.picom.enable = true;
  environment.systemPackages = with pkgs; [
    j4-dmenu-desktop
  ];
}

