{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nodePackages.bash-language-server               # bash
    nodePackages.vscode-langservers-extracted       # css/html/json
    nodePackages.dockerfile-language-server-nodejs  # docker
    go                                              # go
    gopls                                           # go
    jdt-language-server                             # java
    sumneko-lua-language-server                     # lua
    nil                                             # nix
    nodePackages.intelephense                       # php
    python310Packages.python-lsp-server             # python
    cargo                                           # rust
    rust-analyzer                                   # rust
    nodePackages.typescript                         # typescript
    nodePackages.typescript-language-server         # typescript
  ];
}

