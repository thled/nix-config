{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    libinput.enable = true;
    xkbOptions = "compose:menu";
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./xmonad.hs;
    };
    displayManager = {
      defaultSession = "none+xmonad";
      lightdm.enable = true;
      autoLogin = {
        enable = true;
        user = "thled";
      };
    };
  };

  programs.slock.enable = true;

  environment.systemPackages = with pkgs; [
    haskellPackages.xmobar
    dmenu
  ];

  environment.etc."config/xmobarrc".source = ./xmobarrc;
}

