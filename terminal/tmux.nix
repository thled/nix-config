{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    customPaneNavigationAndResize = true;
    escapeTime = 0;
    historyLimit = 10000;
    keyMode = "vi";
    newSession = true;
    shortcut = "a";
    terminal = "tmux-256color";

    extraConfig = ''
      bind-key a send-prefix
      bind-key C-a last-window
      bind-key Escape copy-mode
      bind-key \\ split-window -h -c '#{pane_current_path}'
      bind-key - split-window -v -c '#{pane_current_path}'
      set-option -g status-style bg=black,fg=white
      set-option -g window-status-style bg=black,fg=colour8
      set-option -g window-status-current-style bg=black,fg=white,bold
      set-option -g status-right '%m/%d %H:%M'
      set-option -g focus-events on
      set-option -g mouse on
      set-option -ag terminal-overrides ",xterm-256color:RGB"
    '';
  };
}

