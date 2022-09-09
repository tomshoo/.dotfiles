local M = {}

local cfg = {
    style = "night",
    transparent = (function()
        if vim.fn.exists('g:neovide') == 1 then
            return false
        else
            return true
        end
    end)()
}

function M.setup()
    local colorscheme = 'tokyonight'
    local ok, colors = pcall(require, colorscheme)
    if not ok then
        return false
    end

    colors.setup(cfg)
    local tok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
    if not tok then
        return false
    end
    return true
end

return M
