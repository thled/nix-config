{ pkgs, ... }:
let
  heirline-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "heirline-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "rebelot";
      repo = "heirline.nvim";
      rev = "b69415d912d466db17b8ee1eb777cc7f776a9286";
      sha256 = "0pv320i23wwp58xy3lpiy4j90y6fl8frmw19nk0c8dy9c10pdg6s";
    };
  };
  centerpad-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "centerpad-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "smithbm2316";
      repo = "centerpad.nvim";
      rev = "666641d02fd8c58ac401c1fb6bf596bb00b815fb";
      sha256 = "clHJFfU7F95WYpGVGr3iQEN+00lnS9YxIpLOoH56e68=";
    };
  };
in {
  programs.neovim = {
    enable = true;
    defaultEditor = false;
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
          heirline-nvim                   # statusline
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
          centerpad-nvim                  # zen
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
      "etc/ftplugin/java.vim".text = "setlocal noexpandtab";
      "etc/ftplugin/nix.vim".text = "setlocal tabstop=2 softtabstop=2 shiftwidth=2";
      "etc/ftplugin/typescript.vim".text = "setlocal tabstop=2 softtabstop=2 shiftwidth=2";
    };
  };
}

