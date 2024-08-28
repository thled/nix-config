_: {
  programs.fish = {
    enable = true;
    shellAbbrs = {
      d   = "docker";
      dc  = "docker compose";
      g   = "git";
      gc  = "git commit";
      gd  = "git diff";
      gdt = "git difftool";
      gf  = "git fetch";
      gg  = "git gui";
      gl  = "git log";
      gm  = "git merge";
      gp  = "git push";
      gs  = "git status";
      j   = "just";
      k   = "kubectl";
      ks  = "kubens";
      kx  = "kubectx";
      l   = "eza -la --git";
      t   = "eza -T --git-ignore";
    };
  };

  systemd.tmpfiles.rules = [
    "d /etc/config/fish 0755 thled root -"
  ];
  environment.etc."config/fish/config.fish".source = ./config.fish;
  environment.etc."config/fish/functions/i.fish".source = ./i.fish;
}

