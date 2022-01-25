{ config, pkgs, ... }: {
  time.timeZone = "Europe/Berlin";
  networking.hostName = "NB61";
  environment.variables = {
    XDG_CONFIG_HOME = "/etc/config";
  };
}

