{ pkgs, helix, ... }: {
  environment.systemPackages = [ helix.packages."${pkgs.system}".helix ];
  environment.etc."config/helix/config.toml".source = ./helix.toml;
  # environment.etc."config/helix/languages.toml".source = ./helix_languages.toml;
}
