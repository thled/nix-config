{ config, pkgs, ... }: {
  imports = [
    ./system/user.nix
    ./system/common.nix
    ./wm/xmonad.nix
    ./audio/pulseaudio.nix
    ./terminal/alacritty.nix
    ./terminal/tmux.nix
    ./terminal/fish.nix
    ./terminal/starship.nix
    ./editor/vim.nix
    ./virtualisation/docker.nix
    ./programs/utils.nix
    ./programs/git.nix
    ./programs/ripgrep.nix
    ./programs/apps.nix
  ];
}

