{ ... }:
{
  # disabledModules = [ "services/networking/syncthing.nix" ];
  imports = [
    ./hardware-configuration.nix
    # (master + "/nixos/modules/services/networking/syncthing.nix")
    ./modules
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  system.stateVersion = "22.11";
}
