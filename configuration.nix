{...}: {
  imports = [
    ./modules
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  nix.settings.trusted-users = ["root" "thled"];

  system.stateVersion = "22.11";
}
