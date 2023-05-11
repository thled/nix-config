{ pkgs, config, ... }:
let
  unstable = import
    (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/nixos-unstable)
    { config = config.nixpkgs.config; };
in
{
  environment.systemPackages = with pkgs; [ unstable.helix ];
  environment.etc."config/helix/config.toml".source = ./helix.toml;
}
