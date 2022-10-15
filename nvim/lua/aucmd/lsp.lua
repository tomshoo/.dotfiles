local mapper = require('config.lsp.mappings')
local highlight = require('config.lsp.highlight_symbol')
local sign = require('config.lsp.signatures').setup()
local fmt = require('config.lsp.formatter').setup()
local M = {}

function M.setup()
    local lspattach = vim.api.nvim_create_augroup("LspAttack", { clear = true })
    vim.api.nvim_create_autocmd({ "LspAttach" }, {
        group = lspattach,
        callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)

            if sign then
                require('lsp_signature').on_attach(sign, bufnr)
            end

            if fmt then
                fmt.on_attach(client)
            end
            highlight.setup(client, bufnr)

            if client.name == "rust_analyzer" then
                pcall(function()
                    local rt = require('rust-tools')
                    map("n", "<Leader>h", rt.hover_actions.hover_actions, { buffer = bufnr })
                    map("n", "<Leader>e", rt.expand_macro.expand_macro,
                        { buffer = bufnr, desc = "Expand macro under cursor" })
                end)
            end
            mapper(bufnr)
        end
    })
    return true
end

return M
