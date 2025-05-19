{pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config = {
      alias.dt = "difftool";
      branch.sort = "-committerdate";
      column.ui = "auto";
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
        tool = "difftastic";
      };
      difftool = {
        prompt = "false";
        meld.cmd = "meld \"$LOCAL\" \"$REMOTE\"";
        difftastic.cmd = "difft \"$LOCAL\" \"$REMOTE\"";
      };
      fetch = {
        all = true;
        pruneTags = true;
        prune = true;
      };
      help.autocorrect = "prompt";
      includeIf."gitdir:~/dev/".path = "/etc/gitconfig.private";
      includeIf."gitdir:~/work/".path = "/etc/gitconfig.work";
      init.defaultBranch = "main";
      merge.tool = "meld";
      mergetool.meld.cmd = "meld \"$LOCAL\" \"$MERGED\" \"$REMOTE\" --output \"$MERGED\"";
      pager.difftool = "true";
      push.autosetupremote = true;
      rebase.autoStash = true;
      rebase.updateRefs = true;
      tag.sort = "version:refname";
      user.name = "Thomas Le Duc";
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

