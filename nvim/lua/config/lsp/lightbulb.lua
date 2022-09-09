local M = {}

local cfg = {
    status_text = {
        enabled = true
    },
    autocmd = {
        enabled = true,
        pattern = { '*' },
        events = { 'CursorHold', 'CursorHoldI' }
    }
}

function M.setup()
    local ok, bulb = pcall(require, 'nvim-lightbulb')
    if not ok then
        return false
    end

    bulb.setup(cfg)
    return true
end

return M
