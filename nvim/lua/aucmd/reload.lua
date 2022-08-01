local M = {}

function M.setup()
    vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*",
        callback = function()
            local cf = vim.fn.expand('%:p:h:t') .. '/' .. vim.fn.expand('%:t')

            if cf == "nvim/init.lua" then
                vim.cmd [[source %]]
            elseif cf == "lua/plugins.lua" then
                vim.cmd [[source % | PackerCompile]]
            end
        end
    })
end

return M
