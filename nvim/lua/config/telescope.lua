local M = {}

local cfg = {
    pickers = {
        find_files      = { theme = "dropdown", previewer = false },
        buffers         = { theme = "dropdown", previewer = false },
        builtin         = { theme = "dropdown" },
        lsp_definitions = { theme = "ivy" },
        lsp_references  = { theme = "cursor", previewer = false },
    },
    extensions = {
        ['ui-select'] = { require('telescope.themes').get_cursor() },
        frecency      = {
            ignore_patterns  = { '*.git/*', '*/tmp/*', '*cache**' },
            disable_devicons = false,
            show_unindexed   = false
        }
    }
}

function M.setup()
    local ok, telescope = pcall(require, 'telescope')
    if not ok then
        return false
    end

    telescope.setup(cfg)
    telescope.load_extension('ui-select')
    telescope.load_extension('persisted')
    telescope.load_extension('frecency')
    telescope.load_extension('projects')
end

return M
