{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.starship ];
  environment.etc.starship = {
    target = "config/starship.toml";
    source = ./starship.toml;
    mode = "0755";
    user = "thled";
  };
  environment.variables = {
    STARSHIP_CONFIG = "/etc/config/starship.toml";
  };
}

