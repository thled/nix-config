{ pkgs, ... }: {
  services.xserver = {
    enable = true;
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

  environment.systemPackages = [ 
    pkgs.haskellPackages.xmobar 
    pkgs.dmenu
  ];

  environment.etc."config/xmobarrc".source = ./xmobarrc;
}

