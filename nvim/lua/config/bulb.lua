local M = {}

local cfg = { autocmd = { enabled = true } }

function M.setup()
    local ok, bulb = pcall(require, 'lightbulb')
    if not ok then
        return false
    end

    bulb.setup(cfg)
    return true
end

return M
