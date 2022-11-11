return function(bufnr)
    map('n', 'gd', "<cmd>Telescope lsp_definitions<cr>", { buffer = bufnr, desc = "Go to definition" })
    map('n', '<C-space>', vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover actions" })
    map('n', 'gi', "<cmd>Telescope lsp_implementations<cr>",
        { buffer = bufnr, desc = "List implementations for under the cursor" })
    map('n', '<Leader>Wa', vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc = "Add a new workspace folder" })
    map('n', '<Leader>Wr', vim.lsp.buf.remove_workspace_folder,
        { buffer = bufnr, desc = "Remove a folder from current workspace" })
    map('n', '<Leader>Wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = bufnr, desc = "List folders in workspace" })
    map('n', '<Leader>D', "<cmd>Telescope lsp_type_definitions<cr>", { buffer = bufnr })
    map('n', 'cr', vim.lsp.buf.rename, { buffer = bufnr })
    map('i', '<F2>', "<C-o><cmd>lua vim.lsp.buf.rename()<CR>", { buffer = bufnr })
    map('n', '<Leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = "View code actions for current buffer" })
    map('n', 'gr', "<cmd>Telescope lsp_references<cr>", { buffer = bufnr, desc = "List reference for under cursor" })
end
