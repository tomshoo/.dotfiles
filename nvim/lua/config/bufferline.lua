local M = {}

local cfg = {
    no_name_title = "[New file]",
    exclude_ft = { "scratch" }
}

function M.setup()
    local ok, bufferline = pcall(require, 'bufferline')
    if not ok then
        return false
    end

    vim.api.nvim_create_autocmd('BufWinEnter', {
        pattern = '*',
        callback = function()
            if vim.bo.filetype == 'NvimTree' then
                require('bufferline.api').set_offset(35, 'Explorer')
            end
        end
    })

    vim.api.nvim_create_autocmd('BufWinLeave', {
        pattern = '*',
        callback = function()
            if vim.fn.expand('<afile>'):match('NvimTree') then
                require('bufferline.api').set_offset(0)
            end
        end
    })

    bufferline.setup(cfg)
end

return M
