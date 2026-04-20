{pkgs, ...}: {
  boot.kernelModules = ["uinput"];

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  environment = {
    systemPackages = [
      pkgs.voxtype
    ];
    etc."config/voxtype/config.toml".text =
      #toml
      ''
        [whisper]
        model = "base.en"

        [hotkey]
        enabled = true
        key = "F13"

        [output.notification]
        on_recording_start = false
        on_recording_stop = false
        on_transcription = false

        [audio]
        device = "default"
        sample_rate = 16000
        max_duration_secs = 60

        [audio.feedback]
        enabled = true
        theme = "subtle"
        volume = 0.4

        [text]
        spoken_punctuation = true

        [text.replacements]
        javascript = "JavaScript"
        typescript = "TypeScript"
        python = "Python"

        [output]
        mode = "type"
        driver_order = ["dotool", "clipboard"]
      '';
  };

  systemd.user.services.voxtype = {
    description = "Voxtype push-to-talk voice-to-text daemon";
    wantedBy = ["graphical-session.target"];
    partOf = ["graphical-session.target"];
    after = [
      "graphical-session.target"
      "pipewire.service"
      "pipewire-pulse.service"
    ];
    path = with pkgs; [
      libnotify
      which
      wl-clipboard
    ];
    serviceConfig = {
      ExecStart = "${pkgs.voxtype}/bin/voxtype -q daemon";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
