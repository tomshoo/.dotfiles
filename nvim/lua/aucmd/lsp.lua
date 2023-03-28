local mappers   = {
    require('lsp.tools.rust').mapper,
    require('lsp.mappings'),
}
local highlight = require('lsp.highlight_symbol')
local sign      = require('lsp.signatures').setup()
local fmt       = require('lsp.formatter').setup()
local M         = {}

function M.setup()
    local lspattach = vim.api.nvim_create_augroup("LspAttack", { clear = true })
    vim.api.nvim_create_autocmd({ "LspAttach" }, {
        group = lspattach,
        callback = function(args)
            local bufnr  = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)

            if sign then
                require('lsp_signature').on_attach(sign, bufnr)
            end

            if fmt then
                fmt.on_attach(client)
            end
            highlight.setup(client, bufnr)

            for _, mapper in ipairs(mappers) do
                mapper()
            end
        end
    })
    return true
end

return M
