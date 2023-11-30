return function(bufnr)
    mapkey('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', { buffer = bufnr })
    mapkey('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr })
    mapkey('n', ';t', '<cmd>TroubleToggle document_diagnostics<cr>', { buffer = bufnr })
    mapkey('n', ';T', '<cmd>TroubleToggle workspace_diagnostics<cr>', { buffer = bufnr })
    mapkey('n', ';a', vim.lsp.buf.code_action, { buffer = bufnr, desc = "Show code actions" })
    mapkey('n', ';r', vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol undor cursor" })
end
