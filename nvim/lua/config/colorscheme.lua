local M = {}

local cfg = {
    style = "night",
    transparent = false,
    styles = {
        comments = { italic = true },
        keywords = { bold = true },
        functions = { italic = true, bold = true },
        variables = "NONE",
    },
    lualine_bold = true
}

function M.setup()
    if os.getenv("TERM") == "linux" then
        vim.cmd.colorscheme("ron")
        return true
    end
    if vim.fn.exists('g:neovide') == 0 then
        vim.g.tokyodark_enable_italic = false
        local ok, _ = pcall(vim.cmd.colorscheme, "tokyodark")
        if not ok then
            vim.cmd.colorscheme('elflord')
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
    local tok, _ = pcall(vim.cmd.colorscheme, colorscheme)
    if not tok then
        return false
    end
    return true
end

return M
