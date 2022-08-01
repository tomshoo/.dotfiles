local M = {}

local cfg = {
    tokyonight_style = "night",
    tokyonight_hide_inactive_statusline = true,
    tokyonight_lualine_bold = true,
    neovide = {
        tokyonight_transparent = false,
        tokyonight_dark_float = false,
    },
    term = {
        tokyonight_transparent = true
    }
}

function M.setup()
    for prop, val in pairs(cfg) do
        if prop == "neovide" and vim.fn.exists('g:neovide') == 1 then
            for gprop, gval in pairs(val) do
                vim.g[gprop] = gval
            end
        elseif prop == "term" then
            for tprop, tval in pairs(val) do
                vim.g[tprop] = tval
            end
        else
            vim.g[prop] = val
        end
    end
    vim.cmd [[colorscheme tokyonight]]
    return true
end

return M
