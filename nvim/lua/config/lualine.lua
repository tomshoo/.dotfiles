local M = {}

function LspStatus()
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
        return nil
    end
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
        end
    end
    return nil
end

local filetype = {
    function()
        local res = vim.o.filetype
        if LspStatus() then
            res = res .. ' '
        end
        return res
    end,
    icon = (function()
        local ok, devicon = pcall(require, 'nvim-web-devicons')
        if not ok then
            return nil
        end
        local ic, cl = devicon.get_icon_color(vim.fn.expand('%:t'))
        if ic then
            return {
                string.format("%s", ic),
                align = 'right',
                color = { fg = cl }
            }
        end
        return nil
    end)()
}

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
        component_separator = { left = "", right = "" }
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            "branch",
            "diff",
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
