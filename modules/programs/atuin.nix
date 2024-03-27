{ pkgs, ... }: {
  environment = {
    systemPackages = [ pkgs.atuin ];
    etc."config/atuin/config.toml".source = ./atuin.toml;
  };
}
