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
    asm_lsp = {
        command = "asm-lsp",
    },
    jsonls = {},
    cssls = {},
    vimls = {},
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

    require('config.lsp.tools').setup(formatter, sigup)
    for server, config in pairs(lsp_config) do
        config.on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', '<C-space>', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-i>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<Leader>Wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<Leader>Wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<Leader>Wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<Leader>f<F2>', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<Leader>f', vim.lsp.buf.formatting, opts)
            if formatter then
                formatter.on_attach(client)
            end
            if sigup then
                require('lsp_signature').on_attach(sigup, bufnr)
            end
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
    return true
end

return M
