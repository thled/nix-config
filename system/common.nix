{ config, pkgs, ... }: {
  time.timeZone = "Europe/Berlin";
  networking.hostName = "NB61";

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
  ];

  systemd.tmpfiles.rules = [
    "d /etc/config 0755 thled root -"
  ];
  environment.variables = {
    XDG_CONFIG_HOME = "/etc/config";
  };
}

