{ pkgs, ... }:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  copilot = pkgs.vimUtils.buildVimPlugin {
    name = "copilot";
    src = pkgs.fetchFromGitHub {
      owner = "github";
      repo = "copilot.vim";
      rev = "47eb231463d3654de1a205c4e30567fbd006965d";
      sha256 = "06znz1869h7cdh9xc0b54mysslgpf3qdwsj5zvnzrzk6fnfin03q";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    package = unstable.neovim-unwrapped;
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
          gruvbox-material          # theme
          vim-surround              # surround
          gitsigns-nvim             # git
          comment-nvim              # comment
          lualine-nvim              # statusline
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
        ];
      };
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

