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
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local colors = require("catppuccin.palettes").get_palette()
require('heirline').load_colors(colors)

local ViMode = {
    init = function(self)
        self.mode = vim.fn.mode(1)
        if not self.once then
            vim.api.nvim_create_autocmd("ModeChanged", {
                pattern = "*:*o",
                command = 'redrawstatus'
            })
            self.once = true
        end
    end,
    static = {
        mode_names = {
            n = "N",
            no = "N?",
            nov = "N?",
            noV = "N?",
            ["no\22"] = "N?",
            niI = "Ni",
            niR = "Nr",
            niV = "Nv",
            nt = "Nt",
            v = "V",
            vs = "Vs",
            V = "V_",
            Vs = "Vs",
            ["\22"] = "^V",
            ["\22s"] = "^V",
            s = "S",
            S = "S_",
            ["\19"] = "^S",
            i = "I",
            ic = "Ic",
            ix = "Ix",
            R = "R",
            Rc = "Rc",
            Rx = "Rx",
            Rv = "Rv",
            Rvc = "Rv",
            Rvx = "Rv",
            c = "C",
            cv = "Ex",
            r = "...",
            rm = "M",
            ["r?"] = "?",
            ["!"] = "!",
            t = "T",
        },
        mode_colors = {
            n = "green" ,
            i = "maroon",
            v = "teal",
            V =  "teal",
            ["\22"] =  "teal",
            c =  "peach",
            s =  "lavender",
            S =  "lavender",
            ["\19"] =  "lavender",
            R =  "peach",
            r =  "peach",
            ["!"] =  "maroon",
            t =  "maroon",
        }
    },
    provider = function(self)
        return " %2("..self.mode_names[self.mode].."%)"
    end,
    hl = function(self)
        local mode = self.mode:sub(1, 1)
        return { fg = self.mode_colors[mode], bold = true, }
    end,
    update = { "ModeChanged", },
}


local FileNameBlock = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
}

local FileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(
            filename,
            extension,
            { default = true }
        )
    end,
    provider = function(self)
        return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end
}

local FileName = {
    provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then return "[No Name]" end
        if not conditions.width_percent_below(#filename, 0.5) then
            filename = vim.fn.pathshorten(filename)
        end
        return filename
    end,
    hl = { fg = utils.get_highlight("Directory").fg },
}

local FileFlags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = "[+]",
        hl = { fg = "green", },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = "",
        hl = { fg = "peach", },
    },
}

local FileNameModifer = {
    hl = function()
        if vim.bo.modified then
            return { fg = "teal", bold = true, force=true, }
        end
    end,
}

FileNameBlock = utils.insert(
    FileNameBlock,
    FileIcon,
    utils.insert(FileNameModifer, FileName),
    FileFlags,
    { provider = '%<'}
)

local FileType = {
    provider = function()
        return string.upper(vim.bo.filetype)
    end,
    hl = { fg = "yellow", bg = "mantle", bold = true, },
}

local Ruler = {
    provider = "%7(%l/%3L%):%2c %P",
}

local LSPActive = {
    condition = conditions.lsp_attached,
    update = {'LspAttach', 'LspDetach'},
    provider = "LSP",
    hl = { fg = "green", bg = "mantle", bold = true, },
}

local Diagnostics = {
    condition = conditions.has_diagnostics,

    static = {
        error_icon = " ",
        warn_icon = " ",
        info_icon = " ",
        hint_icon = " ",
    },

    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    end,

    update = { "DiagnosticChanged", "BufEnter", },

    {
        provider = function(self)
            return self.errors > 0 and (self.error_icon .. self.errors .. " ")
        end,
        hl = { fg = "maroon", bg = "mantle", },
    },
    {
        provider = function(self)
            return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
        end,
        hl = { fg = "peach", bg = "mantle", },
    },
    {
        provider = function(self)
            return self.info > 0 and (self.info_icon .. self.info .. " ")
        end,
        hl = { fg = "blue", bg = "mantle", },
    },
    {
        provider = function(self)
            return self.hints > 0 and (self.hint_icon .. self.hints)
        end,
        hl = { fg = "rosewater", bg = "mantle", },
    },
}

ViMode = utils.surround({ "", "" }, "surface0", { ViMode, })

local Align = { provider = "%=" }
local Space = { provider = " " }

local WinBar = { FileNameBlock, }
local StatusLine = { ViMode, Align, Diagnostics, Align, LSPActive, Space, FileType, Space, Ruler, }

require("heirline").setup({
    statusline = StatusLine,
    winbar = WinBar,
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
        ['<Tab>']       = cmp.mapping(function(fallback)
                            if luasnip.expand_or_jumpable() then
                                luasnip.expand_or_jump()
                            else
                                fallback()
                            end
                        end, { "i", "s" }),
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

