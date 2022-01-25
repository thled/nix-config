{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAbbrs = {
      dc = "docker compose";
    };
  };

  systemd.tmpfiles.rules = [
    "d /etc/config/fish 0755 thled root -"
  ];
  environment.etc.fish = {
    target = "config/fish/config.fish";
    source = ./config.fish;
    mode = "0755";
    user = "thled";
  };
}

