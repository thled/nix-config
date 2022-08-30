{ config, pkgs, ... }:
let
  unstable = import
    (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/nixos-unstable)
    { config = config.nixpkgs.config; };
in
{
  environment.systemPackages = with pkgs; [ unstable.zellij ];
  environment.etc."config/zellij/config.yaml".source = ./zellij.yaml;
  environment.etc."config/zellij/themes/catppuccin.yaml".source = ./catppuccin.yaml;
}
