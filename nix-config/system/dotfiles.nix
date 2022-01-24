{ pkgs, ... }: {
  environment.variables = {
    XDG_CONFIG_HOME = "/etc/config";
  };

  environment.etc = {
    "config".source = ./config;
  };
}

