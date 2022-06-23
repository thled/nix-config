{ pkgs, ... }: 
let
  copilot = pkgs.vimUtils.buildVimPlugin {
        name = "copilot-vim";
        src = pkgs.fetchFromGitHub {
          owner = "github";
          repo = "copilot.vim";
          rev = "c2e75a3a7519c126c6fdb35984976df9ae13f564";
          sha256 = "V13La54aIb3hQNDE7BmOIIZWy7In5cG6kE0fti/wxVQ=";
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
          catppuccin-nvim           # theme
          vim-surround              # surround
          gitsigns-nvim             # git
          comment-nvim              # comment
          feline-nvim               # statusline
          nvim-web-devicons         # statusline
          plenary-nvim              # search
          telescope-fzf-native-nvim # search
          telescope-nvim            # search
          nvim-treesitter           # syntax highlighting
          cmp-nvim-lsp              # autocomplete
          cmp-buffer                # autocomplete
          cmp-path                  # autocomplete
          luasnip                   # autocomplete
          cmp_luasnip               # autocomplete
          nvim-cmp                  # autocomplete
          nvim-lspconfig            # lsp
          copilot                   # ai
          refactoring-nvim          # refactoring
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
    rust-analyzer                                   # rust
    nodePackages.typescript                         # typescript
    nodePackages.typescript-language-server         # typescript
    nodePackages.vim-language-server                # vim
  ];
}

