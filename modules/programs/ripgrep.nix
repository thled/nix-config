{ pkgs, ... }: {
  environment = {
    systemPackages = [ pkgs.ripgrep ];
    etc."config/ripgreprc".source = ./ripgreprc;
    variables = {
      RIPGREP_CONFIG_PATH = "/etc/config/ripgreprc";
    };
  };
}

