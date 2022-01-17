{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./user.nix
    ./vim.nix
  ];

  boot.loader.systemd-boot.enable = true;
}
