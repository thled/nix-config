{ config, pkgs, ... }: {
  imports = [
    ./system/user.nix
    ./system/common.nix
    ./terminal/alacritty.nix
    ./terminal/fish.nix
    ./terminal/starship.nix
    ./editor/vim.nix
    ./wm/xmonad.nix
    ./programs/utils.nix
  ];
}

