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

" always show signcolumn
set signcolumn=yes

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
require('lualine').setup {
    sections = {
        lualine_b = {'branch'},
    }
}
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


""""""""""
""" search
""""""""""

lua <<END
require('telescope').load_extension('fzf')
END

" Mappings
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <C-f> <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <C-e> <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <C-_> <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>


"""""""
""" lsp
"""""""

lua <<END
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
    -- Mappings
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('v', '<space>ca', ':<C-U>lua vim.lsp.buf.range_code_action()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)

    -- Config
    vim.lsp.handlers['textDocument/references'] = require('telescope.builtin').lsp_references
end

-- Install language servers
local servers = {
    "vimls", -- vim
}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { 
        on_attach = on_attach,
    }
end
END

