{ pkgs, ... }:
let
  cmp-nvim-lsp-signature-help = pkgs.vimUtils.buildVimPlugin {
    name = "cmp-nvim-lsp-signature-help";
    src = pkgs.fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-nvim-lsp-signature-help";
      rev = "007dd2740d9b70f2688db01a39d6d25b7169cd57";
      sha256 = "L3tw+FYHiz5gYY23Sd9METHlxIvaaHGFJH/Qhc0SkaQ=";
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
          catppuccin-nvim               # theme
          vim-surround                  # surround
          gitsigns-nvim                 # git
          comment-nvim                  # comment
          feline-nvim                   # statusline
          nvim-web-devicons             # statusline
          plenary-nvim                  # search
          telescope-fzf-native-nvim     # search
          telescope-nvim                # search
          nvim-treesitter               # syntax highlighting
          cmp-nvim-lsp                  # autocomplete
          cmp-buffer                    # autocomplete
          cmp-path                      # autocomplete
          luasnip                       # autocomplete
          cmp_luasnip                   # autocomplete
          nvim-cmp                      # autocomplete
          cmp-nvim-lsp-signature-help   # autocomplete
          nvim-lspconfig                # lsp
          refactoring-nvim              # refactoring
        ];
      };
    };
    runtime = {
      "after/ftplugin/typescript.vim".text = "setlocal tabstop=2 softtabstop=2 shiftwidth=2";
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

