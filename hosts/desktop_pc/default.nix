{...}: {
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
    ../../modules/wm/ddcutil.nix
    ../../modules/wm/brightness-toggle.nix
  ];

  networking.hostName = "desktop_pc";
  boot.blacklistedKernelModules = ["mt7921e"];

  thled.niri.extraConfig = ''
    output "HDMI-A-1" {
      mode "3840x2160"
      scale 2
    }
  '';

  thled.niri.extraBinds = ''
    Mod+U hotkey-overlay-title="Toggle Monitor brightness" { spawn "brightness-toggle"; }
  '';
}
