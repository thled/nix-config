alias d   = docker
alias dc  = docker compose
alias j   = just
alias k   = kubectl
alias ks  = kubens
alias kx  = kubectx
alias o   = opencode

def open-repo [] {
  let url = (git remote get-url origin | str replace --regex '^(git@|ssh:\/\/git@)([^:\/]+?)(?:-work)?(?::\d+)?[:\/](.+?)(\.git)?$' 'https://$2/$3')

  ^xdg-open $url
}

let fish_completer = {|spans|
  fish --command $'complete "--do-complete=($spans | str join " ")"'
  | from tsv --flexible --noheaders --no-infer
  | rename value description
}

let zoxide_completer = {|spans|
  $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

let external_completer = {|spans|
  let expanded_alias = scope aliases
  | where name == $spans.0
  | get --optional 0.expansion

  let spans = if $expanded_alias != null {
    $spans
    | skip 1
    | prepend ($expanded_alias | split row ' ' | take 1)
  } else {
    $spans
  }

  match $spans.0 {
    __zoxide_z | __zoxide_zi => $zoxide_completer
    _ => $fish_completer
  } | do $in $spans
}

$env.config = {
  show_banner: false
  completions: {
    external: {
      enable: true
      completer: $external_completer
    }
  }
  keybindings: [
    {
      name: insert_last_token
      modifier: alt
      keycode: char_.
      mode: emacs
      event: [
        { edit: InsertString, value: " !$" }
        { send: Enter }
      ]
    }
  ]
  hooks: {
    env_change: {
      PWD: [{ ||
        if (which direnv | is-empty) {
          return
        }

        direnv export json | from json | default {} | load-env
      }]
    }
  }
}

source ~/.zoxide.nu
source /etc/config/nushell/todo.nu
