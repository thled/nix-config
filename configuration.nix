{ master, ... }:
{
  disabledModules = [ "services/networking/syncthing.nix" ];
  imports = [
    ./hardware-configuration.nix
    (master + "/nixos/modules/services/networking/syncthing.nix")
    ./modules
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  system.stateVersion = "22.11";
}
