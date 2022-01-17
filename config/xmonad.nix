{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    windowManager.xmonad.enable = true;
    displayManager.defaultSession = "none+xmonad";
  }
}

