"""""""""""
""" general
"""""""""""

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


"""""""""
""" theme
"""""""""

set background=dark
let g:gruvbox_material_background = 'hard'
autocmd VimEnter * colorscheme gruvbox-material


""""""""""""""
""" statusline
""""""""""""""

lua <<END
require('lualine').setup()
END


"""""""""""
""" comment
"""""""""""

lua <<END
require('Comment').setup()
END


"""""""""""""""""""""""
""" syntax highlighting
"""""""""""""""""""""""

lua <<END
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "bash",
    "css",
    "dockerfile",
    "fish",
    "go",
    "gomod",
    "graphql",
    "haskell",
    "html",
    "java",
    "javascript",
    "json",
    "json5",
    "jsonc",
    "kotlin",
    "lua",
    "nix",
    "php",
    "python",
    "regex",
    "rust",
    "scss",
    "svelte",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
  },
  sync_install = false,
  highlight = {
    enable = true,
  }
}
END

