local function setup()
    local telescope = require 'telescope'
    local trouble   = require 'trouble.providers.telescope'

    telescope.setup {
        defaults   = {
            border           = true,
            sorting_strategy = 'ascending',
            layout_strategy  = 'bottom_pane',
            layout_config    = {
                height = 0.4,
            },

            mappings         = {
                i = { ['C-q'] = trouble.open_with_trouble },
                n = { ['C-q'] = trouble.open_with_trouble },
            },
        },
        pickers    = {
            buffers         = { theme = 'dropdown', previewer = false },
            lsp_definitions = { theme = 'cursor' },
            lsp_references  = { theme = 'cursor', previewer = false },
        },
        extensions = {
            ['ui-select'] = { require('telescope.themes').get_cursor() },
            frecency      = {
                ignore_patterns = { '*.git/', '*/t(e)?mp(orary)?/*', '*cache*' },
                show_unindexd   = false,
            },
            repo          = {
                settings = { auto_lcd = true },
                list     = { search_dirs = { "~/Projects", "~/.dotfiles" } }
            },
        },
    }

    -- telescope.load_extension 'ui-select'
    telescope.load_extension 'frecency'
    telescope.load_extension 'repo'
end

return {
    'nvim-telescope/telescope.nvim',

    dependencies = {
        'nvim-telescope/telescope-ui-select.nvim',
        'nvim-telescope/telescope-frecency.nvim',
        'cljoly/telescope-repo.nvim',
    },

    config = setup,
}
