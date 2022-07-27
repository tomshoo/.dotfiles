local M = {}

function M.setup()
    local ok, telescope = pcall(require, 'telescope')
    if not ok then
        return false
    end

    telescope.setup()
    telescope.load_extension('frecency')
    telescope.load_extension('projects')
end

return M
