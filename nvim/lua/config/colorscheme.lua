local M = {}

function M.setup()
    if os.getenv("TERM") == "linux" then
        vim.cmd.colorscheme("ron")
        return true
    end
    if vim.fn.exists('g:neovide') == 0 then
        local ok, _ = pcall(vim.cmd.colorscheme, "default")
        return ok
    end
    local colorscheme = 'onedark'

    local ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
    if not ok then
        return false
    end
    return true
end

return M
