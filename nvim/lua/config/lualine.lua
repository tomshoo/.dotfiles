local M = {}

local modes = {
    n = { icon = " " },
    i = { icon = " " },
    v = { icon = " " },
    [''] = { icon = "זּ " },
    V = { icon = " " },
    c = { icon = " " },
    no = { icon = "! " },
    s = { icon = "麗" },
    S = { icon = "礪" },
    [''] = { icon = "" },
    ic = { icon = " " },
    R = { icon = "菱" },
    Rv = { icon = "菱" },
    cv = { icon = "? " },
    ce = { icon = "? " },
    r = { icon = " " },
    rm = { icon = "||" },
    ['r?'] = { icon = " " },
    ['!'] = { icon = " " },
    t = { icon = " " },
}

local function get_lsp()
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
        return clients.name
    end
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
        end
    end
    return false

end

local conditions = {
    buffer_not_empty = function()
        return not (vim.fn.line('$') == 1 and vim.fn.getline(1) == '')
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
    lsp_is_active = function()
        if get_lsp() then return true end
        return false
    end
}

local diagnostics = {
    "diagnostics",
    sources = { 'nvim_lsp' },
    sections = { "error", "warn", "hint" },
    symbols = {
        error = "X: ",
        warn = "!: ",
        hint = "?: ",
    },
    cond = conditions.lsp_is_active
}

local filename = {
    function()
        local name = vim.fn.expand('%:t')
        if name == "" or name == nil then
            return " "
        end

        if vim.bo.modified then
            name = "ﯽ " .. name
        elseif vim.bo.readonly then
            name = " " .. name
        end

        return name
    end,
    color = function()
        if vim.bo.modified then
            return { fg = "#e57474" }
        elseif vim.bo.readonly then
            return { fg = "#f40000" }
        end
        return { fg = "#dadada" }
    end,
}

local filesize = {
    "filesize",
    cond = function()
        return conditions.buffer_not_empty() and conditions.hide_in_width()
    end
}

local lsp = {
    function()
        if conditions.hide_in_width() then
            return get_lsp()
        end
        return ""
    end,
    cond = conditions.lsp_is_active,
    icon = ""
}

local stylespace = {
    function()
        return " "
    end,
    color = { bg = "#0000ff" },
    padding = 0
}

local mode = {
    function()
        return modes[vim.fn.mode()].icon
    end
}

local cfg = {
    options = {
        theme = 'auto',
        disabled_filetypes = {
            "alpha",
            -- "NvimTree",
            "Trouble",
        },
        component_separators = "",
        section_separators = ""
    },
    sections = {
        lualine_a = { stylespace, mode },
        lualine_b = {
            "branch",
            "diff",
            lsp,
            diagnostics,
            filesize,
        },
        lualine_c = {
            '%=',
            filename
        },
        lualine_x = {
            { "encoding", cond = conditions.hide_in_width },
            "fileformat",
            { "filetype", icon = { align = 'right' } },
        },
        lualine_y = { "location" },
        lualine_z = {
            "progress",
            stylespace
        }
    },
    extensions = { 'toggleterm', 'nvim-tree' }
}


function M.setup()
    local ok, lualine = pcall(require, 'lualine')
    if not ok then
        return false
    end

    lualine.setup(cfg)
end

return M
