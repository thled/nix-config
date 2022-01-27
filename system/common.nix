{ config, pkgs, ... }: {
  time.timeZone = "Europe/Berlin";
  networking.hostName = "NB61";

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
  ];

  environment.variables = {
    XDG_CONFIG_HOME = "/etc/config";
  };
}

