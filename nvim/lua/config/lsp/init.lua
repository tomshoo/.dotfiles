local M = {}

local lsp_config = {
    sumneko_lua = {
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT'
                },
                diagnostics = {
                    globals = { 'vim' }
                },
                telimitery = {
                    enable = false
                }
            }
        }
    },
    pyright = {},
    clangd = {},
    bashls = {},
    jsonls = {},
    cssls = {},
    vimls = {},
    html = {},
    gopls = {},
}

function M.setup()
    local cmpup = require('config.lsp.cmpconfig').setup()
    local ok, installer = pcall(require, 'nvim-lsp-installer')
    local lok, lspconfig = pcall(require, 'lspconfig')
    if ok then
        installer.setup {
            automatic_installation = true,
        }
    end
    if not lok then
        return false
    end

    for server, config in pairs(lsp_config) do
        if cmpup then
            config.capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
            config.capabilities.textDocument.foldinRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
            }
        end
        lspconfig[server].setup(config)
    end
    require('config.lsp.tools').setup()
    require('config.lsp.lightbulb').setup()
    require('config.lsp.symbols').setup()

    vim.cmd [[
        highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
        highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
        highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
        highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

        sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
        sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
        sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
        sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
    ]]
    return true
end

return M
