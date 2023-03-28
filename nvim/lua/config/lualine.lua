local M = {}

local conditions = {
    buffer_not_empty = function()
        return not (vim.fn.line('$') == 1 and vim.fn.getline(1) == '')
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 110
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
    lsp_is_active = function()
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return false
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return true
            end
        end
        return false
    end
}

local diagnostics = {
    'diagnostics',
    sources = { 'nvim_lsp' },
    sections = { 'error', 'warn', 'hint' },
    symbols = {
        error = ' ',
        warn = ' ',
        hint = ' ',
    },
    cond = conditions.lsp_is_active
}

local filename = {
    function()
        local name = vim.fn.expand('%:t')
        if name == '' or name == nil then
            return ' '
        end

        if vim.bo.modified then
            name = 'ﯽ ' .. name
        elseif vim.bo.readonly then
            name = ' ' .. name
        end

        return name
    end,
}

local filesize = {
    'filesize',
    cond = conditions.hide_in_width
}

local window = {
    function()
        return vim.api.nvim_win_get_number(0)
    end,
}

local lsp = {
    function()
        local names = {}
        for _, client in ipairs(vim.lsp.get_active_clients({
            bufnr = vim.fn.bufnr()
        })) do
            table.insert(
                names,
                string.len(client.name) <= 15 and client.name or "...")
        end
        return conditions.hide_in_width()
            and '[' .. table.concat(names, ':') .. ']'
            or string.format('[+%d]', #names)
    end,
    cond = conditions.lsp_is_active,
    icon = ' '
}

local trailing_space = {
    function()
        local space = vim.fn.search([[\s\+$]], 'nwc')
        return vim.fn.mode() ~= 'i' and space ~= 0 and ' ' .. space or ''
    end,
    cond = conditions.hide_in_width
}

local mixed_indent = {
    function()
        local space_pat = [[\v^ +]]
        local tab_pat = [[\v^\t+]]
        local space_indent = vim.fn.search(space_pat, 'nwc')
        local tab_indent = vim.fn.search(tab_pat, 'nwc')
        local mixed = (space_indent > 0 and tab_indent > 0)
        local mixed_same_line
        if not mixed then
            mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
            mixed = mixed_same_line > 0
        end
        if not mixed then return '' end
        if mixed_same_line ~= nil and mixed_same_line > 0 then
            return 'MI:' .. mixed_same_line
        end
        local space_indent_cnt = vim.fn.searchcount({
            pattern = space_pat,
            max_count = 1e3
        }).total

        local tab_indent_cnt = vim.fn.searchcount({
            pattern = tab_pat,
            max_count = 1e3
        }).total

        if space_indent_cnt > tab_indent_cnt then
            return vim.fn.mode() ~= 'i' and '' .. tab_indent or ''
        else
            return vim.fn.mode() ~= 'i' and '' .. space_indent or ''
        end
    end,
    cond = conditions.hide_in_width
}

local fileformat = {
    'fileformat',
    fmt = string.upper,
    icons_enabled = false
}

local function diff()
    local gitsigns = vim.b.gitsigns_status_dict
    _G.gitsigns = gitsigns
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed
        }
    end
end

local help = {
    options = {
        theme = "auto",
    },
    filetypes = { 'help' },
    sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'searchcount' },
    }
}

local cfg = {
    options = {
        theme = "auto",
        disabled_filetypes = {
            'alpha',
            -- 'NvimTree',
            'Trouble',
        },
        component_separators = '',
        section_separators = ''
    },
    sections = {
        lualine_a = { window, "mode" },
        lualine_b = {
            filename,
            { 'branch', fmt = string.upper },
            { 'diff', source = diff, symbols = {
                added = ' ',
                modified = '柳',
                removed = ' '
            } },
        },
        lualine_c = {
            lsp,
            diagnostics,
        },
        lualine_x = {
            filesize,
            { 'encoding', cond = conditions.hide_in_width, fmt = string.upper },
        },
        lualine_y = {
            fileformat,
            { 'filetype', icon = { align = 'right' } },
            'location'
        },
        lualine_z = {
            mixed_indent,
            trailing_space,
            'progress',
        }
    },
    extensions = { 'toggleterm', 'nvim-tree', help }
}


function M.setup()
    local lualine = require('lualine')

    lualine.setup(cfg)
end

return M
