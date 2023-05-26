{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ helix ];
  environment.etc."config/helix/config.toml".source = ./helix.toml;
  environment.etc."config/helix/languages.toml".source = ./helix_languages.toml;
}
