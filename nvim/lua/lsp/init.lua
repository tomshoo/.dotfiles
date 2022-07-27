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
    rust_analyzer = {},
    bashls = {},
    asm_lsp = {},
    jsonls = {},
    cssls = {},
    vimls = {}
}

function M.setup(abilities)
    local stat, lsp = pcall(require, "lspconfig")
    if not stat then
        return
    end

    local fstat, formatter = pcall(require, "lsp-format")

    for server, config in pairs(lsp_config) do
        if fstat then
            config.on_attach = formatter.on_attach
        end
        config.capabilities = abilities
        lsp[server].setup(config)
    end
end

return M;
