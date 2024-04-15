{ pkgs, ... }: {
  environment.variables = {
    XDG_CONFIG_HOME = "/etc/config";
    EDITOR = "hx";
  };

  networking.hostName = "NBL0112";

  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      (iosevka-bin.override { variant = "SGr-IosevkaTerm"; })
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "Iosevka Term" ];
      };
    };
  };

  boot.loader.systemd-boot.configurationLimit = 8;

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  systemd.tmpfiles.rules = [
    "d /etc/config 0755 thled root -"
  ];
}

