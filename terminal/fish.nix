{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAbbrs = {
      dc = "docker compose";
      l = "exa -la --git -I .git";
      t = "exa --tree --git-ignore";
    };
  };

  systemd.tmpfiles.rules = [
    "d /etc/config/fish 0755 thled root -"
  ];
  environment.etc."config/fish/config.fish".source = ./config.fish;
}

