{ ... }:
{
  # disabledModules = [ "services/networking/syncthing.nix" ];
  imports = [
    ./hardware-configuration.nix
    # (master + "/nixos/modules/services/networking/syncthing.nix")
    ./modules
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };

    initrd.secrets = {
      "/crypto_keyfile.bin" = null;
    };
  };

  system.stateVersion = "22.11";
}
