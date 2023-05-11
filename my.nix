{ config, pkgs, ... }: {
  imports = [
    ./system/user.nix
    ./system/common.nix
    ./network/networkmanager.nix
    ./network/mail.nix
    ./wm/leftwm.nix
    ./audio/pulseaudio.nix
    ./terminal/alacritty.nix
    ./terminal/fish.nix
    ./terminal/starship.nix
    ./terminal/zellij.nix
    ./editor/vim.nix
    ./editor/helix.nix
    ./virtualisation/docker.nix
    ./virtualisation/virt_manager.nix
    ./network/vpn.nix
    ./programs/utils.nix
    ./programs/git.nix
    ./programs/kubernetes.nix
    ./programs/ripgrep.nix
    ./programs/syncthing.nix
    ./programs/apps.nix
  ];
}

