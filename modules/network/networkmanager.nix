_: {
  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = false;
  # deactivate WiFi
  boot.blacklistedKernelModules = [ "mt7921e" ];
}

