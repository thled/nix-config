{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ helix ];
  environment.etc."config/helix/config.toml".source = ./helix.toml;
}
