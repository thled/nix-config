{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.ripgrep ];

  environment.etc."config/ripgreprc".source = ./ripgreprc;

  environment.variables = {
    RIPGREP_CONFIG_PATH = "/etc/config/ripgreprc";
  };
}

