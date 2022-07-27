local M = {}

local cfg = {
    show_current_context = true,
    show_current_context_start = true,
    space_char_blankline = " ",
    show_end_of_line = true,
    filetype_exclude = {
        "alpha"
    }
}

function M.setup()
    local ok, indentguide = pcall(require, 'indent_blankline')
    if not ok then
        return false
    end
    indentguide.setup(cfg)
end

return M
