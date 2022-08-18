local M = {}

local cfmt = [[clang-format $INPUT ${--style="{IndentWidth: ${tab_width}}"}]]

local cfg = {
    c = { tab_width = 2, formatCommand = cfmt },
    cpp = { tab_width = 2, formatCommand = cfmt }
}

function M.setup()
    local ok, formatter = pcall(require, 'lsp-format')
    if ok then
        formatter.setup(cfg)
        return formatter
    end
    return false
end

return M
