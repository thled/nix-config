"""""""""""
""" general
"""""""""""

" leader key
let mapleader = '\<Space>'

" allow unsaved buffer switch
set hidden

" line numbers
set number relativenumber

" search
set ignorecase smartcase

" indentation
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent

" show trailing spaces
set list listchars=tab:▸\ ,extends:›,precedes:‹,nbsp:␣,trail:· showbreak=↪\ 

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


"""""""
""" git
"""""""

lua <<EOF
require('gitsigns').setup()
EOF


"""""""""""
""" comment
"""""""""""

lua <<EOF
require('Comment').setup()
EOF


""""""""""""""
""" statusline
""""""""""""""

lua <<EOF
require('lualine').setup {
    options = {
        theme                   = 'gruvbox-material',
        component_separators    = { left = '', right = '' },
        section_separators      = { left = '', right = '' },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {},
        lualine_c = {{ 'filename', path = 1 }},
        lualine_x = {
            {
                'diagnostics',
                sources = { 'nvim' },
                symbols = {
                    error   = '',
                    warn    = '',
                    info    = '',
                    hint    = '',
                },
            },
            'filetype',
            'bo:tabstop',
            'encoding',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
}
EOF


""""""""""
""" search
""""""""""

lua <<EOF
require('telescope').load_extension('fzf')
EOF

" Mappings
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <C-f> <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <C-e> <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <C-_> <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>


"""""""""""""""""""""""
""" syntax highlighting
"""""""""""""""""""""""

lua <<EOF
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'bash',
        'css',
        'dockerfile',
        'fish',
        'go',
        'gomod',
        'graphql',
        'haskell',
        'html',
        'java',
        'javascript',
        'json',
        'json5',
        'jsonc',
        'kotlin',
        'lua',
        'nix',
        'php',
        'python',
        'regex',
        'rust',
        'scss',
        'svelte',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vue',
        'yaml',
    },
    sync_install = false,
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            node_decremental = "<BS>",
            scope_incremental = "<TAB>",
        },
    },
    indent = {
        enable = true,
    },
}
EOF


""""""""""""""""
""" autocomplete
""""""""""""""""

set completeopt=menu,menuone,noselect

lua <<EOF
local cmp       = require('cmp')
local luasnip   = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                nvim_lsp    = '[LSP]',
                buffer      = '[Buf]',
                luasnip     = '[Snp]',
                path        = '[Pth]',
            })[entry.source.name]
            return vim_item
        end,
    },
    mapping = {
        ['<C-p>']       = cmp.mapping.select_prev_item(),
        ['<C-n>']       = cmp.mapping.select_next_item(),
        ['<C-d>']       = cmp.mapping.scroll_docs(-4),
        ['<C-f>']       = cmp.mapping.scroll_docs(4),
        ['<C-Space>']   = cmp.mapping.complete(),
        ['<C-e>']       = cmp.mapping.close(),
        ['<Tab>']       = cmp.mapping.select_next_item({behavior=cmp.SelectBehavior.Insert}),
        ['<S-Tab>']     = cmp.mapping.select_prev_item({behavior=cmp.SelectBehavior.Insert}),
        ['<CR>']        = cmp.mapping.confirm({
            behavior    = cmp.ConfirmBehavior.Replace,
            select      = true,
        }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer'   },
        { name = 'luasnip'  },
        { name = 'path'     },
    },
})
EOF


"""""""
""" lsp
"""""""

lua <<EOF
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
    -- Mappings
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gd',           '<cmd>lua vim.lsp.buf.definition()<CR>',                opts)
    buf_set_keymap('n', 'gD',           '<cmd>lua vim.lsp.buf.declaration()<CR>',               opts)
    buf_set_keymap('n', 'gI',           '<cmd>lua vim.lsp.buf.implementation()<CR>',            opts)
    buf_set_keymap('n', 'gr',           '<cmd>lua vim.lsp.buf.references()<CR>',                opts)
    buf_set_keymap('n', '<space>D',     '<cmd>lua vim.lsp.buf.type_definition()<CR>',           opts)
    buf_set_keymap('n', 'K',            '<cmd>lua vim.lsp.buf.hover()<CR>',                     opts)
    buf_set_keymap('n', '<C-k>',        '<cmd>lua vim.lsp.buf.signature_help()<CR>',            opts)
    buf_set_keymap('n', '<space>f',     '<cmd>lua vim.lsp.buf.formatting()<CR>',                opts)
    buf_set_keymap('n', '<space>rn',    '<cmd>lua vim.lsp.buf.rename()<CR>',                    opts)
    buf_set_keymap('n', '<space>ca',    '<cmd>lua vim.lsp.buf.code_action()<CR>',               opts)
    buf_set_keymap('v', '<space>ca',    ':<C-U>lua vim.lsp.buf.range_code_action()<CR>',        opts)
    buf_set_keymap('n', '[d',           '<cmd>lua vim.diagnostic.goto_prev()<CR>',              opts)
    buf_set_keymap('n', ']d',           '<cmd>lua vim.diagnostic.goto_next()<CR>',              opts)
    buf_set_keymap('n', '<space>e',     '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>',  opts)
    buf_set_keymap('n', '<space>q',     '<cmd>lua vim.diagnostic.set_loclist()<CR>',            opts)

    -- Config
    vim.lsp.handlers['textDocument/references']     = require('telescope.builtin').lsp_references
    vim.lsp.handlers['textDocument/implementation'] = require('telescope.builtin').lsp_implementations
    vim.lsp.handlers['textDocument/definition']     = require('telescope.builtin').lsp_definitions
    if client.supports_method('textDocument/documentHighlight') then
        vim.api.nvim_command [[autocmd CursorHold   <buffer> lua vim.lsp.buf.document_highlight()]]
        vim.api.nvim_command [[autocmd CursorMoved  <buffer> lua vim.lsp.buf.clear_references()]]
    end
end

-- Autocomplete capability
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Install language servers w/o special config
local servers = {
    'bashls',           -- bash
    'cssls',            -- css
    'dockerls',         -- docker
    'gopls',            -- go
    'html',             -- html
    'jsonls',           -- json
    'rnix',             -- nix
    'intelephense',     -- php
    'pyright',          -- python
    'rust_analyzer',    -- rust
    'tsserver',         -- typescript
    'vimls',            -- vim
}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { 
        on_attach       = on_attach,
        capabilities    = capabilities,
    }
end

-- Install lua lsp
nvim_lsp.sumneko_lua.setup {
    on_attach       = on_attach,
    capabilities    = capabilities,
    cmd             = { 'lua-language-server' },
    settings        = {
        Lua = {
            telemetry = {
                enable = false,
            },
        },
    },
}
EOF


""""""
""" ai
""""""

" map to CTRL-J
imap <silent><script><expr> <C-J> copilot#Accept('')
let g:copilot_no_tab_map = v:true

