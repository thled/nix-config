{
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      bip = "10.200.0.1/24";
      "default-address-pools" = [
        {
          "base" = "10.200.0.0/16";
          "size" = 24;
        }
      ];
    };
  };
}

