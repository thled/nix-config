{ pkgs, ... }: {
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true;

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];

  systemd.tmpfiles.rules = [
    "d /etc/config/pulse 0755 thled root -"
    "f /etc/config/pavucontrol.ini 0755 thled root -"
  ];
}

