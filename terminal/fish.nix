{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAbbrs = {
      dc = "docker compose";
      gc = "git commit";
      gf = "git fetch";
      gm = "git merge";
      gp = "git push";
      gs = "git status";
      k = "kubectl";
      ks = "kubens";
      kx = "kubectx";
      l = "exa -la --git";
      t = "exa -T --git-ignore";
    };
  };

  systemd.tmpfiles.rules = [
    "d /etc/config/fish 0755 thled root -"
  ];
  environment.etc."config/fish/config.fish".source = ./config.fish;
}

