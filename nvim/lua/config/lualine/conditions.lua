local conditions = {}

conditions.buffer_not_empty = function()
    return not (vim.fn.line('$') == 1 and vim.fn.getline(1) == '')
end

conditions.hide_in_width = function()
    return vim.fn.winwidth(0) > 110
end

conditions.check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir   = vim.fn.finddir('.git', filepath .. ';')

    return gitdir and #gitdir > 0 and #gitdir < #filepath
end

conditions.lsp_is_active = function()
    return #(vim.lsp.buf_get_clients()) ~= 0
end

return conditions
