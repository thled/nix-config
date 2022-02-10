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
      customRC = ''
        """""""""""""""
        """ general """
        """""""""""""""

        " leader key
        let mapleader = "\<Space>"

        " allow unsaved buffer switch
        set hidden

        " line numbers
        set number relativenumber

        " search
        set ignorecase smartcase

        " indentation
        set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent

        " incremental substitute
        set inccommand=nosplit

        " ruler
        set colorcolumn=120
        highlight ColorColumn ctermbg=238 guibg=lightgrey

        " keymap for no highlighting
        nnoremap <nowait><silent> <C-C> :nohlsearch<CR>
      '';
    };
  };
}

