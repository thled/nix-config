{ ... }: {
  programs.git = {
    enable = true;
    config = {
      alias.dt = "difftool";
      init.defaultBranch = "main";
      diff.tool = "difftastic";
      difftool.prompt = "false";
      difftool.meld.cmd = "meld \"$LOCAL\" \"$REMOTE\"";
      difftool.difftastic.cmd = "difft \"$LOCAL\" \"$REMOTE\"";
      merge.tool = "meld";
      mergetool.meld.cmd = "meld \"$LOCAL\" \"$MERGED\" \"$REMOTE\" --output \"$MERGED\"";
      pager.difftool = "true";
      user.name = "Thomas Le Duc";
      includeIf."gitdir:~/projects/".path = "/etc/gitconfig.private";
      includeIf."gitdir:/etc/nixos/nix-config/".path = "/etc/gitconfig.private";
      includeIf."gitdir:~/work/".path = "/etc/gitconfig.work";
    };
  };

  environment.etc."config/git/ignore".source = ./gitignore_global;

  environment.etc."gitconfig.private".text =
    "[user]
    email = dev@tleduc.de";

  environment.etc."gitconfig.work".text =
    "[user]
    email = leduc@publicplan.de";
}

