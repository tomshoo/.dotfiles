local config = {
    load = {
        ['core.autocommands']            = {},
        ['core.integrations.treesitter'] = {},
        ['core.defaults']                = {},
        ['core.dirman']                  = { config = { workspaces = { Wayland = '~/Documents/Wayland' } } },
        ['core.concealer']               = { config = { folds = false } },
        ['core.export']                  = {},
        ['core.export.markdown']         = {},
        ['core.completion']              = { config = { engine = 'nvim-cmp' } },
    }
}

return {
    'nvim-neorg/neorg',
    ft   = "norg",
    opts = config
}
