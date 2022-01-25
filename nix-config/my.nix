{ config, pkgs, ... }: {
  imports = [
    ./system/user.nix
    ./system/common.nix
    ./terminal/alacritty.nix
    ./editor/vim.nix
    ./wm/xmonad.nix
  ];
}

