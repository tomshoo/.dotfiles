local function setup()
    local ok, onedark = pcall(require, 'onedark')

    onedark.setup { style = 'darker' }
    onedark.load()

    if not ok then
        vim.cmd.colorscheme 'elflord'
    end
end

return {
    'navarasu/onedark.nvim',
    config = setup,
    lazy   = false,
}
