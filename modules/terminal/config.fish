direnv hook fish | source

if status is-interactive
    function starship_transient_prompt_func
        printf (set_color 949494)"$(date '+%H:%M') \$ "
    end
    enable_transience

    set -U fish_greeting
    fish_config theme choose fish\ default

    atuin init fish | source
    zoxide init fish | source
end
