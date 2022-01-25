{ pkgs, ... }: {
  environment.variables = {
    XDG_CONFIG_HOME = "/etc/config";
  };
}

