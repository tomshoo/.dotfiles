local M = {}

local cfg = {
    render = "background"
}

function M.setup()
    local ok, colorizer = pcall(require, 'nvim-highlight-colors')
    if not ok then
        return false
    end
    colorizer.setup(cfg)
    return true
end

return M
