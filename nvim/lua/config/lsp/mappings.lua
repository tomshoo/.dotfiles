return function(bufnr)
    map('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
    map('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
    map('n', '<C-space>', vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover actions" })
    map('n', 'gi', vim.lsp.buf.implementation,
        { buffer = bufnr, desc = "List implementations for under the cursor" })
    map('n', '<Leader>Wa', vim.lsp.buf.add_workspace_folder,
        { buffer = bufnr, desc = "Add a new workspace folder" })
    map('n', '<Leader>Wr', vim.lsp.buf.remove_workspace_folder,
        { buffer = bufnr, desc = "Remove a folder from current workspace" })
    map('n', '<Leader>Wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = bufnr, desc = "List folders in workspace" })
    map('n', '<Leader>D', vim.lsp.buf.type_definition, { buffer = bufnr })
    map('n', '<Leader>f<F5>', vim.lsp.buf.rename, { buffer = bufnr })
    map('n', '<Leader>ca', vim.lsp.buf.code_action,
        { buffer = bufnr, desc = "View code actions for current buffer" })
    map('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = "List reference for under cursor" })
end
