{ pkgs, ... }: 
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  nvim-lsp-installer = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-lsp-installer";
    src = pkgs.fetchFromGitHub {
      owner = "thled";
      repo = "nvim-lsp-installer";
      rev = "181a0c5ce1a28c29e74a1d824312ba42325b9d8b";
      sha256 = "0ldv72h9bgnl0ww9ysf9hipz6ggczy2fr62cm8hyspmgdj1f5v89";
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
    withPython3 = true;
    withRuby = false;
    configure = {
      customRC = builtins.readFile ./init.vim;
      packages.myVimPackages = with pkgs.vimPlugins; {
        start = [
          gruvbox-material          # theme
          lualine-nvim              # statusline
          comment-nvim              # comment
          nvim-treesitter           # syntax highlighting
          plenary-nvim              # search
          telescope-fzf-native-nvim # search
          telescope-nvim            # search
          nvim-lspconfig            # lsp
          cmp-nvim-lsp              # autocomplete
          cmp-buffer                # autocomplete
          cmp-path                  # autocomplete
          luasnip                   # autocomplete
          cmp_luasnip               # autocomplete
          nvim-cmp                  # autocomplete
          gitsigns-nvim             # git
          vim-surround              # surround
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

