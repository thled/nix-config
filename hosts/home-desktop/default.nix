{...}: {
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "home-desktop";
  boot.blacklistedKernelModules = ["mt7921e"];

  thled.niri.extraConfig = ''
    output "DP-1" {
      mode "3840x2160@144.000"
      scale 2
      position x=0 y=0
    }
  '';
}
