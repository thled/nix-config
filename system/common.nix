{ pkgs, ... }: {
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  boot.loader.systemd-boot.configurationLimit = 8;

  time.timeZone = "Europe/Berlin";
  networking.hostName = "NBL0112";

  fonts.fonts = with pkgs; [
    cascadia-code
  ];

  systemd.tmpfiles.rules = [
    "d /etc/config 0755 thled root -"
  ];
  environment.variables = {
    XDG_CONFIG_HOME = "/etc/config";
    EDITOR = "hx";
  };
}

