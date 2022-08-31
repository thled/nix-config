{ config, pkgs, ... }: {
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  boot.loader.systemd-boot.configurationLimit = 8;

  time.timeZone = "Europe/Berlin";
  networking.hostName = "NB61";

  fonts.fonts = with pkgs; [
    nerdfonts
  ];

  systemd.tmpfiles.rules = [
    "d /etc/config 0755 thled root -"
  ];
  environment.variables = {
    XDG_CONFIG_HOME = "/etc/config";
  };
}

