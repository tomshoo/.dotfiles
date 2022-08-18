local M = {}

local cfg = {
    ["core.defaults"] = {}
}

function M.setup()
    local ok, norg = pcall(require, 'neorg')
    if not ok then
        return false
    end
    norg.setup(cfg)
    return true
end

return M
