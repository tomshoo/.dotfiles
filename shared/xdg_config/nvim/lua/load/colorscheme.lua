local function setup()
    local ok, _ = pcall(vim.cmd.colorscheme, 'catppuccin-mocha')

    if not ok then
        vim.cmd.colorscheme 'elflord'
    end
end

return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = setup,
}
