{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./xmonad.hs;
    };
    displayManager.defaultSession = "none+xmonad";
  };

  environment.systemPackages = [ pkgs.haskellPackages.xmobar ];

  environment.etc = {
    "xmobarrc".source = ./xmobarrc;
  };
}

