local M = {}

local cfg = {
    style = "night",
    transparent = false,
    styles = {
        comments = "NONE",
        keywords = "italic",
        functions = "underline",
        variables = "NONE",
    },
    lualine_bold = true
}

function M.setup()
    if vim.fn.exists('g:neovide') == 0 then
        local ok, _ = pcall(vim.cmd [[ set termguicolors | colorscheme nightfly ]])
        if not ok then
            return false
        end
        return true
    end
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
