return function (client, bufnr)
    if not client.server_capabilities.documentHighlightProvider then return end

    vim.cmd [[
    hi! LspReferenceRead cterm=bold ctermbg=gray ctermfg=black guibg=gray guifg=black
    hi! LspReferenceText cterm=bold ctermbg=gray ctermfg=black guibg=gray guifg=black
    hi! LspReferenceWrite cterm=bold ctermbg=gray ctermfg=black guibg=gray guifg=black
    ]]

    vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })

    vim.api.nvim_clear_autocmds({
        buffer = bufnr,
        group = 'lsp_document_highlight',
    })

    vim.api.nvim_create_autocmd({ 'CursorHold' }, {
        group = 'lsp_document_highlight',
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        group = 'lsp_document_highlight',
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
    })
end
