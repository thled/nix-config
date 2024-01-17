function starship_transient_prompt_func
  printf (set_color 949494)"$(date '+%H:%M') \$ "
end
enable_transience

direnv hook fish | source
zoxide init fish | source

fish_config theme choose fish\ default
set fish_color_autosuggestion 555
