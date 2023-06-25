local telescope = require 'telescope'

telescope.setup {
    defaults   = {
        border           = true,
        sorting_strategy = 'ascending',
        layout_strategy  = 'bottom_pane',
        layout_config    = {
            height = 0.4,
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
        }
    },
}

telescope.load_extension 'ui-select'
telescope.load_extension 'frecency'
