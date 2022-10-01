local M = {}

local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ('  %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
end

local ftMap = {
    NeogitCommitMessage = { 'indent' }
}

function M.setup()
    local ok, ufo = pcall(require, 'ufo')
    if not ok then
        return false
    end

    vim.opt.foldcolumn = '1'
    vim.opt.foldlevelstart = 1000

    vim.keymap.set("n", "fO", require('ufo').openAllFolds)
    vim.keymap.set("n", "fC", require('ufo').closeAllFolds)


    -- global handler
    ufo.setup({
        fold_virt_text_handler = handler,
        provider_selector = function(_, ft, _)
            return ftMap[ft] or { 'treesitter', 'indent' }
        end
    })

    -- buffer scope handler
    -- will override global handler if it is existed
    local bufnr = vim.api.nvim_get_current_buf()
    ufo.setFoldVirtTextHandler(bufnr, handler)
end

return M
