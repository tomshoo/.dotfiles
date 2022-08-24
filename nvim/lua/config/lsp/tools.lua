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
                local opts = { buffer = bufnr, noremap = true, silent = true }
                vim.keymap.set("n", "<Leader>h", tool.hover_actions.hover_actions, opts)
                vim.keymap.set("n", "<Leader>a", tool.code_action_group.code_action_group, opts)
                vim.keymap.set("n", "<Leader>e", tool.expand_macro.expand_macro, opts)
                vim.keymap.set("n", "<Leader>r", tool.runnables.runnables, opts)
            end,
            ["rust-analyzer"] = {
                checkOnSave = {
                    enable = true,
                    command = "clippy",
                    allTargets = false,
                    overrideCommand = "clippy",
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
