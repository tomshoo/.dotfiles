local M = {}

local cfg = {
    history = 30,
}

M.setup = function()
    local ok, clip = pcall(require, 'neoclip')
    if not ok then
        return false
    end
    clip.setup(cfg)
    return true
end

return M
