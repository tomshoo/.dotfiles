local M = {}

local cfg = {
    indent_lines = true,
    fold_closed = ">>+",
    signs = {
        error = "[error]",
        warning = "[warn]",
        hint = "[help]",
        information = "[info]"
    },
    use_diagnostic_signs = false
}

function M.setup()
    local ok, trouble = pcall(require, 'trouble')
    if not ok then
        return false
    end

    trouble.setup(cfg)
    return true
end

return M
