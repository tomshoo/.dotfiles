local M = {}

local cfg = {}

function M.setup()
    local ok, sig = pcall(require, 'lsp_signature')
    if not ok then
        return false
    end

    return sig.setup(cfg)
end

return M
