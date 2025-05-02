alias d   = docker
alias dc  = docker compose
alias g   = git
alias gc  = git commit
alias gd  = git diff
alias gdt = git difftool
alias gf  = git fetch
alias gg  = git gui
alias gl  = git log --pretty='tformat:%C(always,yellow)%h%C(always,reset) %C(always,green)%ar%C(always,reset) %C(always,bold blue)%an%C(always,reset) %C(always,red)%d%C(always,reset) %s'
alias gp  = git push
alias gs  = git status
alias j   = just
alias k   = kubectl
alias ks  = kubens
alias kx  = kubectx

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
  | get -i 0.expansion

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
