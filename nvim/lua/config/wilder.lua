local M = {}

local cfg = {
    modes = { ':', '?', '/' }
}

function M.setup()
    local ok, wilder = pcall(require, 'wilder')
    if not ok then
        return false
    end
    wilder.set_option('renderer', wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
        highlighter = wilder.basic_highlighter(),
        left = { ' ', wilder.popupmenu_devicons() },
        border = 'rounded',
        -- min_width = '100%',
        min_height = 0,
        max_height = '70%',
        prompt_position = 'top',
        reverse = 1,
    })))
    wilder.setup(cfg)
    return true
end

return M
