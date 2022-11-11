local M = {}

function M.setup()
    local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", { clear = true })
    vim.opt.number = true
    vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
        group = numbertoggle,
        pattern = "*",
        command = [[if &nu && mode() != "i" | set rnu | endif]]
    })
    vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
        group = numbertoggle,
        pattern = "*",
        command = "if &nu | set nornu | endif"
    })
    vim.api.nvim_create_autocmd({ "InsertEnter", "BufWinLeave", "WinLeave", "BufLeave" }, {
        pattern = "*",
        command = "set nocursorline"
    })
    vim.api.nvim_create_autocmd({ "InsertLeave", "FocusGained", "BufWinEnter", "WinEnter", "BufEnter" }, {
        pattern = "*",
        command = "set cursorline"
    })
end

return M
