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
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    allTargets = false
                }
            }
        }
    },
    bashls = {},
    asm_lsp = {},
    jsonls = {},
    cssls = {},
    vimls = {},
}

function M.setup()
    require('config.lsp.tools').setup()
    local cmpup = require('config.lsp.cmpconfig').setup()
    local ok, installer = pcall(require, 'nvim-lsp-installer')
    local lok, lspconfig = pcall(require, 'lspconfig')
    local fok, formatter = pcall(require, 'lsp-format')
    if ok then
        installer.setup {
            automatic_installation = true,
        }
    end
    if not lok then
        return false
    end

    if fok then
        formatter.setup()
    end
    for server, config in pairs(lsp_config) do
        if fok then
            config.on_attach = formatter.on_attach
        end
        if cmpup then
            config.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
        end
        lspconfig[server].setup(config)
    end
    return true
end

return M
