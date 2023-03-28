local M = {}

local cfg = {
    always_trigger = true,
    border = "rounded",
    hint_prefix = "-> "
}

function M.setup()
    local ok, sig = pcall(require, 'lsp_signature')
    if not ok then
        return false
    end

    return sig.setup(cfg)
end

return M
