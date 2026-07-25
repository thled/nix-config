{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bash-language-server # bash
    vscode-langservers-extracted # css/html/json
    dockerfile-language-server # docker
    go # go
    gopls # go
    jdt-language-server # java
    nil # nix
    intelephense # php
    python314Packages.python-lsp-server # python
    cargo # rust
    rust-analyzer # rust
    typescript # typescript
    typescript-language-server # typescript
  ];
}
