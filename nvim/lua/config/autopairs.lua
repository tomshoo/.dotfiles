local M = {}

local cfg = {
    disable_filetype = {
        "scratch",
        "nofile",
        "TelescopePrompt"
    },
    enable_check_bracket_line = false,
    check_ts = true,
    ts_config = {
        rust = { "string", "character" }
    }
}
function M.setup()
    local ok, autopairs = pcall(require, 'nvim-autopairs')
    if not ok then
        return false
    end

    autopairs.setup(cfg)

    local rule = require('nvim-autopairs.rule')
    local condition = require('nvim-autopairs.conds')

    autopairs.add_rules({
        rule(' ', ' ')
            :with_pair(function(opts)
                local pair = opts.line:sub(opts.col - 1, opts.col)
                return vim.tbl_contains({ '()', '{}', '[]' }, pair)
            end)
            :with_move(condition.none())
            :with_cr(condition.none())
            :with_del(function(opts)
                local col = vim.api.nvim_win_get_cursor(0)[2]
                local context = opts.line:sub(col - 1, col + 2)
                return vim.tbl_contains({ '(  )', '{  }', '[  ]' }, context)
            end),

        rule('', ' )')
            :with_pair(condition.none())
            :with_move(function(opts) return opts.char == ')' end)
            :with_cr(condition.none())
            :with_del(condition.none())
            :use_key(')'),

        rule('', ' }')
            :with_pair(condition.none())
            :with_move(function(opts) return opts.char == '}' end)
            :with_cr(condition.none())
            :with_del(condition.none())
            :use_key('}'),

        rule('', ' ]')
            :with_pair(condition.none())
            :with_move(function(opts) return opts.char == ']' end)
            :with_cr(condition.none())
            :with_del(condition.none())
            :use_key(']'),
    })

end

return M
