{ pkgs, ... }: {
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true;

  systemd.tmpfiles.rules = [
    "d /etc/config/pulse 0755 thled root -"
  ];

  environment.systemPackages = [ pkgs.pavucontrol ];
}

