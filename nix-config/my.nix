{ config, pkgs, ... }: {
  imports = [
    ./system/user.nix
    ./system/dotfiles.nix
    ./terminal/alacritty.nix
    ./editor/vim.nix
    ./wm/xmonad.nix
  ];
}

