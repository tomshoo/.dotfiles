local M = {}

_G.loaded_rust_tools = false

function M.mapper(bufnr)
    if not _M.loaded_rust_tools then
        return false
    end

    local rt = require('rust-tools')
    map("n", "<Leader>h", rt.hover_actions.hover_actions, { buffer = bufnr })
    map("n", "<Leader>e", rt.expand_macro.expand_macro,
        { buffer = bufnr, desc = "Expand macro under cursor" })
    return true
end

function M.setup()
    local ok, tool = pcall(require, 'rust-tools')
    if not ok then
        return false
    end

    tool.setup {
        autoSetHints = true,
        server = {
            settings = { ["rust-analyzer"] = {
                checkOnSave = {
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
            }
        },
        tools = {
            parameter_hints_prefix = " <- ",
            other_hints_prefix = " => ",
            right_align = true
        }
    }

    _M.loaded_rust_tools = true
    return true
end

return M
