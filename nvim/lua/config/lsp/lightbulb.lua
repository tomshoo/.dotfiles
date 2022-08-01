local M = {}

function M.setup()
    local ok, bulb = pcall(require, 'nvim-lightbulb')
    if not ok then
        return false
    end

    bulb.setup({ autocmd = { enabled = true } })
    return true
end

return M
