{ config, pkgs, ... }: {
  imports = [
    ./system/user.nix
    ./editor/vim.nix
    ./wm/xmonad.nix
  ];
}

