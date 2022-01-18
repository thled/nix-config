{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./nix-config/my.nix
  ];

  boot.loader.systemd-boot.enable = true;
}
