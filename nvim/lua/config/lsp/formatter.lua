local M = {}

local cfg = {}

function M.setup()
    local ok, formatter = pcall(require, 'lsp-format')
    if ok then
        formatter.setup(cfg)
        return formatter
    end
    return false
end

return M
