local M = {}

function M.setup()
    for _, tool in ipairs({
        'config.lsp.tools.rust'
    }) do
        pcall(function()
            require(tool).setup()
        end)
    end
end

return M
