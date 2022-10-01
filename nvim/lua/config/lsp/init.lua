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
    efm = {
        flags = {
            debounce_text_changes = 150,
        },
        init_options = { documentFormatting = true },
        filetypes = { "python" },
        settings = {
            rootMarkers = { ".git/" },
            languages = {
                python = {
                    { formatCommand = "black --quiet -", formatStdin = true }
                }
            }
        }
    },
    html = {},
    gopls = {},
}

function M.setup()
    local cmpup = require('config.lsp.cmpconfig').setup()
    local sigup = require('config.lsp.signatures').setup()
    local ok, installer = pcall(require, 'nvim-lsp-installer')
    local lok, lspconfig = pcall(require, 'lspconfig')
    local formatter = require('config.lsp.formatter').setup()
    if ok then
        installer.setup {
            automatic_installation = true,
        }
    end
    if not lok then
        return false
    end

    for server, config in pairs(lsp_config) do
        config.on_attach = function(client, bufnr)
            require('config.lsp.mappings')(bufnr)
            if formatter then
                formatter.on_attach(client)
            end
            if sigup then
                require('lsp_signature').on_attach(sigup, bufnr)
            end
            require('config.lsp.highlight_symbol').setup(bufnr)
        end
        if cmpup then
            config.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
            config.capabilities.textDocument.foldinRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
            }
        end
        lspconfig[server].setup(config)
    end
    require('config.lsp.tools').setup(formatter, sigup)
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
