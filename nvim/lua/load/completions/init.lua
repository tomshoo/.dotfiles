local cmp      = require 'cmp'
local au_pairs = require 'nvim-autopairs.completion.cmp'
local snippets = require 'load.completions.snippets'


local function enable()
    local ctx = require 'cmp.config.context'
    return (vim.api.nvim_get_mode().mode == 'c')
        or not (ctx.in_treesitter_capture('comment') or ctx.in_syntax_group('Comment'))
end

local function setup(_, opts)
    local default_opts  = opts.default
    local filetypes     = opts.filetypes
    local cmd_line_opts = opts.cmd_line_opts

    cmp.event:on('confirm_done', au_pairs.on_confirm_done())
    cmp.setup(default_opts)
    cmp.setup.cmdline(':', cmd_line_opts[':'])

    for ft, ft_opts in pairs(filetypes) do
        cmp.setup.filetype(ft, ft_opts)
    end
end

local default_config = {
    enabled = enable,
    mapping = cmp.mapping.preset.insert {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<Tab>'] = cmp.mapping(snippets.select_next_item),
        ['<S-Tab>'] = cmp.mapping(snippets.select_previous_item)
    },
    sources = {
        { name = 'snippy' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer' },
    },
    snippet = {
        expand = snippets.expand_snippet,
    }
}

local opts = {
    default = default_config,
    filetypes = {
        ['norg'] = require 'load.completions.filetypes.norg',
        ['git']  = require 'load.completions.filetypes.git',
        ['lua']  = require 'load.completions.filetypes.lua',
        ['toml'] = require 'load.completions.filetypes.toml',
    },
    cmd_line_opts = {
        [':'] = {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources {
                { name = 'path' },
                { name = 'cmdline' },
            }
        },
    }
}

return {
    'hrsh7th/nvim-cmp',
    config       = setup,
    opts         = opts,
    event        = { "InsertEnter", 'CmdlineEnter' },
    dependencies = {
        'dcampos/nvim-snippy',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'dcampos/cmp-snippy',
        'Saecki/crates.nvim',
    }
}
