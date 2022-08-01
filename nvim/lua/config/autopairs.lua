local M = {}

local cfg = {
    disable_filetype = {
        "scratch",
        "nofile"
    },
    check_ts = true,
}
function M.setup()
    local ok, autopairs = pcall(require, 'nvim-autopairs')
    if not ok then
        return false
    end

    autopairs.setup(cfg)

    local rule = require('nvim-autopairs.rule')

    autopairs.add_rules({
        rule(" ", " "):with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({ "()", "{}", "[]" }, pair)
        end),

        rule("{ ", " }"):with_pair(function()
            return false
        end):with_move(function(opts)
            return opts.prev_char:match(".?*") ~= nil
        end):use_key("}"),

        rule("[ ", " ]"):with_pair(function()
            return false
        end):with_move(function(opts)
            return opts.prev_char:match(".?*") ~= nil
        end):use_key("]"),

        rule("( ", " )"):with_pair(function()
            return false
        end):with_move(function(opts)
            return opts.prev_char:match(".?*") ~= nil
        end):use_key(")"),
    })
    return true
end

return M
