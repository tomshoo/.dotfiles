local M = {}

local colors = {
    black       = '#06080A',
    bg0         = '#11121D',
    bg1         = '#1A1B2A',
    bg2         = '#212234',
    bg3         = '#353945',
    bg4         = '#4A5057',
    bg5         = '#282c34',
    bg_red      = '#FE6D85',
    bg_green    = '#98C379',
    bg_blue     = '#9FBBF3',
    diff_red    = '#773440',
    diff_green  = '#587738',
    diff_blue   = '#354A77',
    diff_add    = '#1E2326',
    diff_change = '#262b3d',
    diff_delete = '#281B27',
    fg          = '#A0A8CD',
    red         = '#EE6D85',
    orange      = '#F6955B',
    yellow      = '#D7A65F',
    green       = '#95C561',
    blue        = '#7199EE',
    cyan        = '#38A89D',
    purple      = '#A485DD',
    grey        = '#4A5057',
    none        = 'NONE',
}

local modes = {
    n      = { icon = ' ', color = colors.blue },
    i      = { icon = ' ', color = colors.green },
    v      = { icon = ' ', color = colors.cyan },
    ['']  = { icon = 'זּ ', color = colors.cyan },
    V      = { icon = ' ', color = colors.cyan },
    c      = { icon = ' ', color = colors.yellow },
    no     = { icon = '! ', color = colors.blue },
    s      = { icon = '麗', color = colors.purple },
    S      = { icon = '礪', color = colors.purple },
    ['']  = { icon = '礪', color = colors.purple },
    ic     = { icon = ' ', color = colors.green },
    R      = { icon = '菱', color = colors.red },
    Rv     = { icon = '菱', color = colors.red },
    cv     = { icon = '? ', color = colors.yellow },
    ce     = { icon = '? ', color = colors.yellow },
    r      = { icon = ' ', color = colors.orange },
    rm     = { icon = '||', color = colors.orange },
    ['r?'] = { icon = ' ', color = colors.orange },
    ['!']  = { icon = ' ', color = colors.blue },
    t      = { icon = ' ', color = colors.grey },
}


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
    color = function()
        if vim.bo.modified then
            return { fg = colors.red, bg = colors.diff_red }
        elseif vim.bo.readonly then
            return { fg = colors.black, bg = colors.bg_red }
        end
        return { fg = colors.black, bg = colors.bg_green }
    end,
}

local filesize = {
    'filesize',
    cond = function()
        return conditions.buffer_not_empty() and conditions.hide_in_width()
    end
}

local window = {
    function()
        return vim.api.nvim_win_get_number(0)
    end,
    color = function()
        return { fg = colors.black, bg = modes[vim.fn.mode()].color }
    end,
}

local lsp = {
    function()
        local names = {}
        for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = vim.fn.bufnr() })) do
            table.insert(names, client.name)
        end
        return '[' .. table.concat(names, ':') .. ']'
    end,
    cond = function() return conditions.lsp_is_active() and conditions.hide_in_width() end,
    icon = ' '
}

local trailing_space = {
    function()
        local space = vim.fn.search([[\s\+$]], 'nwc')
        return vim.fn.mode() ~= 'i' and space ~= 0 and ' ' .. space or ''
    end,
    color = { fg = colors.black, bg = colors.blue },
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
        local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
        local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
        if space_indent_cnt > tab_indent_cnt then
            return vim.fn.mode() ~= 'i' and '' .. tab_indent or ''
        else
            return vim.fn.mode() ~= 'i' and '' .. space_indent or ''
        end
    end,
    color = { fg = colors.black, bg = colors.red },
    cond = conditions.hide_in_width
}

local stylespace = {
    function()
        return ' '
    end,
    color = function() return { bg = modes[vim.fn.mode()].color } end,
    padding = 0
}

local mode = {
    function()
        return modes[vim.fn.mode()].icon
    end,
    color = function() return { fg = modes[vim.fn.mode()].color, bg = colors.bg0 } end
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
            modified = gitsigns.modified,
            removed = gitsigns.removed
        }
    end
end

local theme = {
    normal = {
        a = { bg = colors.bg0, fg = colors.blue, gui = 'bold' },
        b = { bg = colors.bg1, fg = colors.fg },
        c = { bg = colors.bg2, fg = colors.blue }
    },
    insert = {
        a = { bg = colors.bg0, fg = colors.green, gui = 'bold' },
        b = { bg = colors.bg1, fg = colors.fg },
        c = { bg = colors.bg2, fg = colors.green }
    },
    visual = {
        a = { bg = colors.bg0, fg = colors.purple, gui = 'bold' },
        b = { bg = colors.bg1, fg = colors.fg },
        c = { bg = colors.bg2, fg = colors.purple }
    },
    replace = {
        a = { bg = colors.bg0, fg = colors.red, gui = 'bold' },
        b = { bg = colors.bg1, fg = colors.fg },
        c = { bg = colors.bg2, fg = colors.red }
    },
    command = {
        a = { bg = colors.bg0, fg = colors.yellow, gui = 'bold' },
        b = { bg = colors.bg1, fg = colors.fg },
        c = { bg = colors.bg2, fg = colors.black }
    },
    inactive = {
        a = { bg = colors.bg2, fg = colors.grey, gui = 'bold' },
        b = { bg = colors.bg2, fg = colors.grey },
        c = { bg = colors.bg2, fg = colors.grey }
    }
}

local help = {
    options = {
        theme = theme,
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
        lualine_a = { window, mode },
        lualine_b = {
            { 'branch', fmt = string.upper },
            { 'diff', source = diff, symbols = { added = ' ', modified = '柳 ', removed = ' ' } },
            lsp,
            diagnostics,
            filesize,
        },
        lualine_c = {
            '%=',
            filename,
            mixed_indent,
            trailing_space
        },
        lualine_x = {
            { 'encoding', cond = conditions.hide_in_width, fmt = string.upper },
        },
        lualine_y = { fileformat, { 'filetype', icon = { align = 'right' } }, 'location' },
        lualine_z = {
            'progress',
            stylespace
        }
    },
    extensions = { 'toggleterm', 'nvim-tree', help }
}


function M.setup()
    local ok, lualine = pcall(require, 'lualine')
    if not ok then
        return false
    end

    lualine.setup(cfg)
end

return M
