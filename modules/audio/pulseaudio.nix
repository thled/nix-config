{ pkgs, ... }: {
  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  # sound.enable = true;
  # hardware = {
  #   pulseaudio = {
  #     enable = true;
  #     extraConfig = ''
  #       load-module module-null-sink sink_name=Source
  #       load-module module-virtual-source source_name=VirtualMic master=Source.monitor
  #     '';
  #   };
  #   bluetooth.enable = true;
  # };
  # nixpkgs.config.pulseaudio = true;

  # systemd.tmpfiles.rules = [
  #   "d /etc/config/pulse 0755 thled root -"
  # ];

  environment.systemPackages = [ pkgs.pavucontrol ];
}

