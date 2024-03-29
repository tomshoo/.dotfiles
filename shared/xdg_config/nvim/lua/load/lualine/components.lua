local conditions = require('load.lualine.conditions')
local components = {}

components.mode = {
    'mode',
    fmt = function(str)
        return ('[' .. string.sub(str, 1, 3):lower() .. ']')
    end
}

components.diff = {
    'diff',
    source = function()
        local gitdiff = vim.b.gitsigns_status_dict
        return gitdiff and {
            added    = gitdiff.added,
            removed  = gitdiff.removed,
            modified = gitdiff.changed,
        } or nil
    end
}

components.lsp = {
    function()
        local names   = {}
        local clients = vim.lsp.get_active_clients({ bufnr = vim.fn.bufnr() })

        for _, client in ipairs(clients) do table.insert(names, client.name) end

        return conditions.hide_in_width()
            and '[' .. table.concat(names, ':') .. ']'
            or string.format('[+%d]', #names)
    end,
    cond = conditions.lsp_is_active,
    icon = ' '
}

components.fileformat = {
    'fileformat',
    icons_enabled = false,
    fmt           = string.upper,
}

components.filename = {
    'filename',
    newfile_status = true,
    path           = 1,

    symbols        = {
        unamed   = '[unamed]',
        newfile  = '[new]',
        readonly = '[ro]'
    }
}

components.mixed_indent = {
    function()
        local space_pat    = [[\v^ +]]
        local tab_pat      = [[\v^\t+]]
        local space_indent = vim.fn.search(space_pat, 'nwc')
        local tab_indent   = vim.fn.search(tab_pat, 'nwc')
        local mixed        = (space_indent > 0 and tab_indent > 0)
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

        return (space_indent_cnt > tab_indent_cnt)
            and ('MI:%d'):format(tab_indent)
            or ('MI:%d'):format(space_indent)
    end,
    cond = conditions.hide_in_width,
}

components.trailing_space = {
    function()
        local trailing_space_cnt = vim.fn.search([[\s\+$]], 'nwc')

        return trailing_space_cnt ~= 0
            and ('TR:%d'):format(trailing_space_cnt)
            or ''
    end,

    cond = function()
        return conditions.hide_in_width() and vim.fn.mode() ~= 'i'
    end
}

components.window_number = function()
    return vim.api.nvim_win_get_number(0)
end

components.buffers = {
    'buffers',
    show_filename_only = false,
    mode = 2,
}

return components
