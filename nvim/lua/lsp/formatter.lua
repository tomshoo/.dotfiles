local M = {}

local cfg = {}

function M.setup()
    local ok, formatter = pcall(require, 'lsp-format')
    if not ok then
        return false
    end
    pcall(function()
        local nullls = require('null-ls')
        local fmt = nullls.builtins.formatting
        local diag = nullls.builtins.diagnostics

        nullls.setup({ sources = {
            fmt.autopep8,
            diag.shellcheck
        } })
    end)
    formatter.setup(cfg)
    return formatter
end

return M
