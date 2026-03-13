{...}: {
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  networking.hostName = "work-laptop";
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };
}
