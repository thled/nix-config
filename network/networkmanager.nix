{ pkgs, ... }: {
  networking.networkmanager = {
    enable = true;
    packages = [
      pkgs.networkmanager-fortisslvpn
    ];
  };

  environment.etc."NetworkManager/system-connections/office.nmconnection" = {
    source = ./office.nmconnection;
    mode = "0600";
  };
}

