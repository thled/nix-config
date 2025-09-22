_: {
  programs.fish = {
    enable = true;
    shellAbbrs = {
      d = "docker";
      dc = "docker compose";
      g = "git";
      gc = "git commit";
      gd = "git diff";
      gdt = "git difftool";
      gf = "git fetch";
      gg = "git gui";
      gl = "git log --pretty='tformat:%C(always,yellow)%h%C(always,reset) %C(always,green)%ar%C(always,reset) %C(always,bold blue)%an%C(always,reset) %C(always,red)%d%C(always,reset) %s'";
      gm = "git merge";
      gp = "git push";
      gs = "git status";
      j = "just";
      k = "kubectl";
      ks = "kubens";
      kx = "kubectx";
    };
  };

  systemd.tmpfiles.rules = [
    "d /etc/config/fish 0755 thled root -"
  ];
}
