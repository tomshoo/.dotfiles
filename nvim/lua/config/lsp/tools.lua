local M = {}

local function rusttools()
    local ok, tool = pcall(require, 'rust-tools')
    if not ok then
        return
    end

    tool.setup {
        autoSetHints = true,
        server = {
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

function M.setup()
    rusttools()
end

return M
