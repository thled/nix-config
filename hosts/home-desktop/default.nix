{...}: {
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "home-desktop";
  boot.blacklistedKernelModules = ["mt7921e"];

  thled.niri.extraConfig = ''
    output "HDMI-A-1" {
      mode "3840x2160"
      scale 2
    }
  '';
}
