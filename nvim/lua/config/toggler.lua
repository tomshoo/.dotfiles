local M = {}

local cfg = {
    inverses = {
        ['ok'] = 'not ok',
        ['not'] = '',
    },
}

function M.setup()
    local ok, toggler = pcall(require, 'nvim-toggler')
    if not ok then
        return false
    end

    toggler.setup(cfg)
    return true
end

return M
