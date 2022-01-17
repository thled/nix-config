{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./user.nix
    ./vim.nix
    ./xmonad.nix
  ];

  boot.loader.systemd-boot.enable = true;
}
