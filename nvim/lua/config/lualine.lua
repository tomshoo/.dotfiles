local M = {}

local diagnostics = {
    "diagnostics",
    sources = { 'nvim_lsp' },
    sections = { "error", "warn", "hint" },
    symbols = {
        error = "X: ",
        warn = "!: ",
        hint = "?: ",
    }
}

local filetype = {
    "filetype",
    icon = { align = "right" }
}

local cfg = {
    options = {
        theme = 'auto',
        disabled_filetypes = {
            "alpha",
            "NvimTree",
            "minimap",
            "Trouble",
            "toggleterm"
        },
        component_separators = {
            left = "",
            right = ""
        }
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            "branch",
            "diff"
        },
        lualine_c = {
            diagnostics,
            "filename"
        },
        lualine_x = {
            "encoding",
            "fileformat",
            filetype
        },
        lualine_y = { "progress" },
        lualine_z = {
            "location",
            "spaces"
        }
    }

}

function M.setup()
    local ok, lualine = pcall(require, 'lualine')
    if not ok then
        return false
    end

    lualine.setup(cfg)
end

return M
