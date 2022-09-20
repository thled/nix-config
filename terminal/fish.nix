{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAbbrs = {
      dc = "docker compose";
      gc = "git commit";
      gd = "git diff";
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
    shellAliases = {
      i = "echo \"Subject: $argv\" | sendmail (cat ~/.inbox_email) && echo \"Send to inbox:\"";
    };
  };

  systemd.tmpfiles.rules = [
    "d /etc/config/fish 0755 thled root -"
  ];
  environment.etc."config/fish/config.fish".source = ./config.fish;
}

