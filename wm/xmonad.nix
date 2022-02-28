{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    xkbOptions = "compose:rwin";
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

  environment.systemPackages = with pkgs; [
    haskellPackages.xmobar
    dmenu
  ];

  environment.etc."config/xmobarrc".source = ./xmobarrc;
}

