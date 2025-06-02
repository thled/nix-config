{pkgs, ...}: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [
        "--filter=until=24h"
      ];
    };
    defaultNetwork.settings.dns_enabled = true;
  };

  environment.systemPackages = with pkgs; [podman-compose];
}
