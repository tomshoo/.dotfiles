local M = {}

local function rusttools(formatter, sigup)
    local ok, tool = pcall(require, 'rust-tools')
    if not ok then
        return
    end

    tool.setup {
        autoSetHints = true,
        server = {
            on_attach = function(client, bufnr)
                if formatter then
                    formatter.on_attach(client)
                end
                if sigup then
                    require('lsp_signature').on_attach(sigup, bufnr)
                end
                map("n", "<Leader>h", tool.hover_actions.hover_actions, { buffer = bufnr })
                map("n", "<Leader>e", tool.expand_macro.expand_macro,
                    { buffer = bufnr, desc = "Expand macro under cursor" })
                require('config.lsp.mappings')(bufnr)
            end,
            ["rust-analyzer"] = {
                checkOnSave = {
                    enable = true,
                    command = "clippy",
                    allTargets = false,
                },
                diagnostics = {
                    disabled = { "unresolved-import" }
                },
                cargo = {
                    loadOutDirsFromCheck = true
                }
            }
        },
        tools = {
            parameter_hints_prefix = " <- ",
            other_hints_prefix = " => ",
            right_align = true
        }
    }
end

function M.setup(formatter, sigup)
    rusttools(formatter, sigup)
end

return M
