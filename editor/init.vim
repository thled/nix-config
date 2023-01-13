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
set ignorecase smartcase nohlsearch

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

" global statusline
set laststatus=3


"""""""""
""" theme
"""""""""

set termguicolors

let g:catppuccin_flavour = "mocha"
colorscheme catppuccin


""""""""""""
""" terminal
""""""""""""

" remap Esc to be consistent with other modes
tnoremap <Esc> <C-\><C-n>
" send Esc to terminal with <C-v><Esc>
tnoremap <C-v><Esc> <Esc>

" show terminal cursor in normal mode
highlight! link TermCursor Cursor
highlight! TermCursorNC guibg=#b4befe guifg=#11111b


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
local clrs = require("catppuccin.palettes").get_palette()

local components = require('catppuccin.groups.integrations.feline').get()
components.active[3][3] = nil
require("feline").setup({
    components = components,
})

local provider = {
    name = 'file_info',
    opts = {
        type = 'relative',
    },
}
local short_provider = {
    name = 'file_info',
    opts = {
        type = 'relative-short',
    },
}
local active_hl = {
    fg = clrs.subtext1,
    bg = clrs.surface0,
}
local inactive_hl = {
    fg = clrs.overlay1,
    bg = clrs.surface0,
}

local winbar_components = {
    active = {{}},
    inactive = {{}},
}
winbar_components.active[1][1] = {
    provider = provider,
    short_provider = short_provider,
    hl = active_hl,
}
winbar_components.inactive[1][1] = {
    provider = provider,
    short_provider = short_provider,
    hl = inactive_hl,
}
require('feline').winbar.setup({
    components = winbar_components,
})
EOF


""""""""""
""" search
""""""""""

lua <<EOF
require('telescope').load_extension('fzf')
EOF

" Mappings
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files({layout_strategy='vertical', layout_config={width=0.5}})<CR>
nnoremap <C-f> <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <C-e> <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <C-_> <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>


"""""""""""""""""""""""
""" syntax highlighting
"""""""""""""""""""""""

lua <<EOF
require('nvim-treesitter.configs').setup {
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
        ['<Up>']        = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior }),
        ['<Down>']      = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior }),
        ['<C-p>']       = cmp.mapping.select_prev_item(),
        ['<C-n>']       = cmp.mapping.select_next_item(),
        ['<C-u>']       = cmp.mapping.scroll_docs(-4),
        ['<C-d>']       = cmp.mapping.scroll_docs(4),
        ['<C-Space>']   = cmp.mapping.complete(),
        ['<C-e>']       = cmp.mapping.close(),
        ['<CR>']        = cmp.mapping.confirm(),
    },
    preselect = cmp.PreselectMode.None,
    sources = {
        { name = 'nvim_lsp_signature_help'  },
        { name = 'nvim_lsp'                 },
        { name = 'buffer'                   },
        { name = 'luasnip'                  },
        { name = 'path'                     },
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
    local opts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n',         'gd',           '<cmd>lua vim.lsp.buf.definition()<CR>',                opts)
    vim.keymap.set('n',         'gD',           '<cmd>lua vim.lsp.buf.declaration()<CR>',               opts)
    vim.keymap.set('n',         'gI',           '<cmd>lua vim.lsp.buf.implementation()<CR>',            opts)
    vim.keymap.set('n',         'gr',           '<cmd>lua vim.lsp.buf.references()<CR>',                opts)
    vim.keymap.set('n',         '<space>D',     '<cmd>lua vim.lsp.buf.type_definition()<CR>',           opts)
    vim.keymap.set('n',         'K',            '<cmd>lua vim.lsp.buf.hover()<CR>',                     opts)
    vim.keymap.set('n',         '<C-k>',        '<cmd>lua vim.lsp.buf.signature_help()<CR>',            opts)
    vim.keymap.set('n',         '<space>f',     '<cmd>lua vim.lsp.buf.format()<CR>',                    opts)
    vim.keymap.set('n',         '<space>rn',    '<cmd>lua vim.lsp.buf.rename()<CR>',                    opts)
    vim.keymap.set({'n', 'v'},  '<space>ca',    '<cmd>lua vim.lsp.buf.code_action()<CR>',               opts)
    vim.keymap.set('n',         '[d',           '<cmd>lua vim.diagnostic.goto_prev()<CR>',              opts)
    vim.keymap.set('n',         ']d',           '<cmd>lua vim.diagnostic.goto_next()<CR>',              opts)
    vim.keymap.set('n',         '<space>e',     '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>',  opts)
    vim.keymap.set('n',         '<space>q',     '<cmd>lua vim.diagnostic.set_loclist()<CR>',            opts)

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
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

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

-- Install java lsp
nvim_lsp.jdtls.setup{
    on_attach       = on_attach,
    capabilities    = capabilities,
    cmd             = { 'jdt-language-server', '-data', '/home/thled/jdtls/workspace' },
}
EOF

