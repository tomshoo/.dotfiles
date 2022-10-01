local M = {}

function M.setup(bufnr)
    -- print(client.server_capabilities.document_highlight)
    -- if client.server_capabilities.document_highlight then
    vim.cmd [[
            hi! LspReferenceRead cterm=bold ctermbg=red guibg=#2c3043
            hi! LspReferenceText cterm=bold ctermbg=red guibg=#2c3043
            hi! LspReferenceWrite cterm=bold ctermbg=red guibg=#2c3043
        ]]
    vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
    vim.api.nvim_clear_autocmds({
        buffer = bufnr,
        group = 'lsp_document_highlight',
    })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = 'lsp_document_highlight',
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
        group = 'lsp_document_highlight',
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
    })
    -- end
end

return M
