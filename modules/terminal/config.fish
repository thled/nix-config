function starship_transient_prompt_func
    printf (set_color 949494)"$(date '+%H:%M') \$ "
end
enable_transience

fish_config theme choose fish\ default
# set fish_color_autosuggestion 555

direnv hook fish | source

if status is-interactive
    atuin init fish | source
    zoxide init fish | source
end
