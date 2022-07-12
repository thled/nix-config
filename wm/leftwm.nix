{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    libinput.enable = true;
    xkbOptions = "compose:menu";
    windowManager.leftwm = {
      enable = true;
    };
    displayManager = {
      defaultSession = "none+leftwm";
      lightdm.enable = true;
      autoLogin = {
        enable = true;
        user = "thled";
      };
    };
  };

  environment.etc."config/leftwm/config.toml".source = ./config.toml;
  environment.etc."config/leftwm/themes/current".source = ./basic_polybar;

  programs.slock.enable = true;
  services.picom.enable = true;
  environment.systemPackages = with pkgs; [
    dmenu
    polybar
  ];
}

