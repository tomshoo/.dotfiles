local snippy = require 'snippy'
local cmp    = require 'cmp'
local M      = {}

function M.select_next_item(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    elseif snippy.can_expand_or_advance() then
        snippy.expand_or_advance()
    else
        fallback()
    end
end

function M.select_previous_item(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    elseif snippy.can_jump(-1) then
        snippy.jump(-1)
    else
        fallback()
    end
end

function M.expand_snippet(args)
    snippy.expand_snippet(args.body)
end

return M
