M = {}

function M.setup()
    local RustKeys = vim.api.nvim_create_augroup("RustKeys", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "rust",
        group = RustKeys,
        callback = function()
            local req = "<cmd>lua require"
            map("n", "<Leader>e", req .. "('rust-tools.expand_macro').expand_macro()<CR>")
            map("n", "<Leader>i", req .. "('rust-tools.inlay_hints').inlay_hints()<CR>")
            map("n", "<Leader>r", req .. "('rust-tools.runnables').runnables()<CR>")
            map("n", "<Leader>h", req .. "('rust-tools.hover_actions').hover_actions()<CR>")
        end
    })
end

return M
