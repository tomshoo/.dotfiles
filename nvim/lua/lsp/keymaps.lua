return function(bufnr)
    map('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', { buffer = bufnr })
    map('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr })
    map('n', '<leader>a', vim.lsp.buf.code_action, { buffer = bufnr })
    map('n', '<leader>r', vim.lsp.buf.rename, { buffer = bufnr })
end
