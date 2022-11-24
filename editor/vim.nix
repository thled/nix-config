{ pkgs, ... }:
let
  cmp-nvim-lsp-signature-help = pkgs.vimUtils.buildVimPlugin {
    name = "cmp-nvim-lsp-signature-help";
    src = pkgs.fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-nvim-lsp-signature-help";
      rev = "3dd40097196bdffe5f868d5dddcc0aa146ae41eb";
      sha256 = "0kfa0pw5yx961inirqwi0fjvgdbmsgw16703mw2w9km8313x17zw";
    };
  };
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
    configure = {
      customRC = builtins.readFile ./init.vim;
      packages.myVimPackages = with pkgs.vimPlugins; {
        start = [
          catppuccin-nvim                 # theme
          vim-surround                    # surround
          gitsigns-nvim                   # git
          comment-nvim                    # comment
          vim-unimpaired                  # bracket mappings
          feline-nvim                     # statusline
          nvim-web-devicons               # statusline
          plenary-nvim                    # search
          telescope-fzf-native-nvim       # search
          telescope-nvim                  # search
          cmp-nvim-lsp                    # autocomplete
          cmp-buffer                      # autocomplete
          cmp-path                        # autocomplete
          luasnip                         # autocomplete
          cmp_luasnip                     # autocomplete
          nvim-cmp                        # autocomplete
          cmp-nvim-lsp-signature-help     # autocomplete
          nvim-lspconfig                  # lsp
          (nvim-treesitter.withPlugins (  # highlighting
            plugins: with plugins; [
              tree-sitter-bash
              tree-sitter-clojure
              tree-sitter-css
              tree-sitter-dockerfile
              tree-sitter-fish
              tree-sitter-go
              tree-sitter-gomod
              tree-sitter-graphql
              tree-sitter-haskell
              tree-sitter-html
              tree-sitter-java
              tree-sitter-javascript
              tree-sitter-json
              tree-sitter-json5
              tree-sitter-lua
              tree-sitter-make
              tree-sitter-markdown
              tree-sitter-nix
              tree-sitter-php
              tree-sitter-python
              tree-sitter-regex
              tree-sitter-rust
              tree-sitter-scss
              tree-sitter-svelte
              tree-sitter-toml
              tree-sitter-tsx
              tree-sitter-typescript
              tree-sitter-vim
              tree-sitter-vue
              tree-sitter-yaml
            ]
          ))
        ];
      };
    };
    runtime = {
      "etc/ftplugin/nix.vim".text = "setlocal tabstop=2 softtabstop=2 shiftwidth=2";
      "etc/ftplugin/typescript.vim".text = "setlocal tabstop=2 softtabstop=2 shiftwidth=2";
    };
  };

  # LSPs
  nixpkgs.config.allowUnfree = true; # for intelephense
  environment.systemPackages = with pkgs; [
    nodePackages.bash-language-server               # bash
    nodePackages.vscode-langservers-extracted       # css/html/json
    nodePackages.dockerfile-language-server-nodejs  # docker
    go                                              # go
    gopls                                           # go
    sumneko-lua-language-server                     # lua
    rnix-lsp                                        # nix
    nodePackages.intelephense                       # php
    nodePackages.pyright                            # python
    cargo                                           # rust
    rust-analyzer                                   # rust
    nodePackages.typescript                         # typescript
    nodePackages.typescript-language-server         # typescript
    nodePackages.vim-language-server                # vim
  ];
}

