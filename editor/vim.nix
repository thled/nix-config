{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
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
          gruvbox-material  # theme
          lualine-nvim      # statusline
          comment-nvim      # comment
          nvim-treesitter   # syntax highlighting
        ];
      };
    };
  };
}

