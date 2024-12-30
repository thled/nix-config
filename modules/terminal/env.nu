def create_left_prompt [] {
    let dir = match (do --ignore-errors { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)(ansi reset)"

    $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
}

$env.PROMPT_COMMAND = {|| create_left_prompt | append $"\n(ansi grey)(date now | format date '%H:%M') " }
$env.PROMPT_COMMAND_RIGHT = {||}
$env.PROMPT_INDICATOR = {|| "$ "}
$env.PROMPT_MULTILINE_INDICATOR = {||}
$env.TRANSIENT_PROMPT_COMMAND = {||}

zoxide init nushell | save -f ~/.zoxide.nu
