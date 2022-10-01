local M = {}

local cfg = {}

function M.setup()
    local ok, surr = pcall(require, 'nvim-surround')
    if not ok then
        return false
    end

    surr.setup(cfg)
    return true
end

return M
