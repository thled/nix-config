{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAbbrs = {
      dc = "docker compose";
    };
  };

  environment.etc.fish = {
    target = "config/fish/config.fish";
    source = ./config.fish;
    mode = "0755";
    user = "thled";
  };

  environment.systemPackages = [ pkgs.starship ];
}

