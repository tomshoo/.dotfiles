local nvim_tree = require 'nvim-tree'

nvim_tree.setup {
    disable_netrw        = true,
    hijack_netrw         = true,
    auto_reload_on_write = true,
    open_on_tab          = true,
    hijack_cursor        = true,
    sync_root_with_cwd   = true,
    reload_on_bufenter   = true,
    respect_buf_cwd      = true,
    update_cwd           = true,


    filters = { dotfiles = true },


    git = {
        ignore       = false,
        show_on_dirs = true
    },


    view = {
        side       = "right",
        width      = 35,
        signcolumn = "yes"
    },


    diagnostics = {
        enable       = true,
        show_on_dirs = true,
    },


    renderer = {
        group_empty            = true,
        highlight_opened_files = "icon",
        indent_markers         = { enable = true },


        icons = {
            git_placement = "after",
            show          = { folder_arrow = false }
        }
    }
}
