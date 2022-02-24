{ pkgs, ... }: {
  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      diff.tool = "meld";
      difftool.prompt = "false";
      difftool.meld.cmd = "meld \"$LOCAL\" \"$REMOTE\"";
      merge.tool = "meld";
      mergetool.meld.cmd = "meld \"$LOCAL\" \"$MERGED\" \"$REMOTE\" --output \"$MERGED\"";
    };
  };
}

