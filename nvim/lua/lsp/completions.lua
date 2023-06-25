local comp   = require 'cmp'
local pairs  = require 'nvim-autopairs.completion.cmp'
local snippy = require 'snippy'

comp.event:on(
    'confirm_done',
    pairs.on_confirm_done()
)

comp.setup {
    enabled = function()
        local ctx = require 'cmp.config.context'
        return (vim.api.nvim_get_mode().mode == 'c')
            or not (ctx.in_treesitter_capture ('comment') or ctx.in_syntax_group('Comment'))
    end,

    mapping = comp.mapping.preset.insert {
        ['<C-b>'] = comp.mapping.scroll_docs(-4),
        ['<C-f>'] = comp.mapping.scroll_docs(4),
        ['<C-Space>'] = comp.mapping.complete(),
        ['<C-e>'] = comp.mapping.abort(),
        ['<CR>'] = comp.mapping.confirm({ select = true }),
        ['<Up>'] = comp.mapping.select_prev_item(),
        ['<Down>'] = comp.mapping.select_next_item(),
        ['<Tab>'] = comp.mapping(function(fallback)
            if comp.visible() then
                comp.select_next_item()
            elseif snippy.can_expand_or_advance() then
                snippy.expand_or_advance()
            else
                fallback()
            end
        end),
        ['<S-Tab>'] = comp.mapping(function(fallback)
            if comp.visible() then
                comp.select_prev_item()
            elseif snippy.can_jump(-1) then
                snippy.jump(-1)
            else
                fallback()
            end
        end)
    },

    sources = {
        {name = 'snippy'},
        {name = 'nvim_lsp'},
        {name = 'path'},
        {name = 'nvim_lua'},
        {name = 'crates'},
    },

    snippet = {
        expand = function(args) snippy.expand_snippet(args.body) end
    },
}
