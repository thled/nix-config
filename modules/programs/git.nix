_: {
  programs.git = {
    enable = true;
    config = {
      alias.dt = "difftool";
      init.defaultBranch = "main";
      diff.tool = "difftastic";
      difftool = {
        prompt = "false";
        meld.cmd = "meld \"$LOCAL\" \"$REMOTE\"";
        difftastic.cmd = "difft \"$LOCAL\" \"$REMOTE\"";
      };
      merge.tool = "meld";
      mergetool.meld.cmd = "meld \"$LOCAL\" \"$MERGED\" \"$REMOTE\" --output \"$MERGED\"";
      pager.difftool = "true";
      user.name = "Thomas Le Duc";
      includeIf."gitdir:~/dev/".path = "/etc/gitconfig.private";
      includeIf."gitdir:~/work/".path = "/etc/gitconfig.work";
    };
  };

  environment.etc = {
    "config/git/ignore".source = ./gitignore_global;
    "gitconfig.private".text =
      "[user]
      email = dev@tleduc.de";

    "gitconfig.work".text =
      "[user]
      email = leduc@publicplan.de";
  };
}

