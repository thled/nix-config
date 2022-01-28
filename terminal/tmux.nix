{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 1;
    historyLimit = 10000;
    keyMode = "vi";
    newSession = true;
    shortcut = "a";
    terminal = "tmux-256color";
  };
}

