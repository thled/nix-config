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

  programs.slock.enable = true;

  environment.systemPackages = with pkgs; [
    dmenu
  ];
}

