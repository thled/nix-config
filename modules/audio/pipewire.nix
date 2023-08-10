{ pkgs, ... }: {
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    alsa.enable = true;
    alsa.support32Bit = true;
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  hardware.bluetooth.enable = true;
  
  environment.systemPackages = [ pkgs.pavucontrol ];
}

