local M = {}

local cfg = {
    disable_netrw = true,
    hijack_netrw = true,
    auto_reload_on_write = true,
    open_on_tab = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    reload_on_bufenter = true,
    respect_buf_cwd = true,
    filters = {
        dotfiles = true
    },
    git = {
        show_on_dirs = true
    },
    view = {
        side = "left",
        width = 35,
        signcolumn = "yes"
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
    },
    renderer = {
        group_empty = true,
        highlight_opened_files = "icon",
        indent_markers = {
            enable = true
        },
        icons = {
            git_placement = "after",
            show = {
                folder_arrow = false
            }
        }
    }
}

function M.setup()
    local ok, tree = pcall(require, 'nvim-tree')
    if not ok then
        return false
    end

    tree.setup(cfg)
    return true
end

return M
