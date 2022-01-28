{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.starship ];
  environment.etc."config/starship.toml".source = ./starship.toml;
  environment.variables = {
    STARSHIP_CONFIG = "/etc/config/starship.toml";
  };
}

