local M = {}

local function generate_config()
    local cok, cmp = pcall(require, 'cmp')
    if not cok then
        return nil
    end

    local sok, snippy = pcall(require, 'snippy')

    local config = {
        enabled = function()
            local context = require("cmp.config.context")
            if vim.api.nvim_get_mode().mode == 'c' then
                return true
            else
                return not context.in_treesitter_capture("comment") and
                    not context.in_syntax_group("Comment")
            end
        end,
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<Up>'] = cmp.mapping.select_prev_item(),
            ['<Down>'] = cmp.mapping.select_next_item(),
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif snippy.can_expand_or_advance() then
                    snippy.expand_or_advance()
                else
                    fallback()
                end
            end),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif snippy.can_jump(-1) then
                    snippy.jump(-1)
                else
                    fallback()
                end
            end)
        }),
        sources = {
            { name = 'snippy' },
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'buffer' },
            { name = 'nvim_lua' },
        }
    }

    if sok then
        config.snippet = {
            expand = function(args) snippy.expand_snippet(args.body)
            end
        }
    end

    return config
end

function M.setup()
    local cfg = generate_config()
    if cfg == nil then
        return false
    end

    local cmp = require('cmp')
    cmp.setup(cfg)
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.insert({
            ['<C-Up>'] = cmp.mapping.select_prev_item(),
            ['<C-Down>'] = cmp.mapping.select_next_item(),
        }),
        sources = { { name = 'cmdline' } }
    })

    cmp.setup.cmdline('/', {
        sources = { { name = 'buffer' } }
    })
    return true
end

return M
