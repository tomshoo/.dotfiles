local M = {}

function M.setup()
    for _, tool in ipairs({
        'lsp.tools.rust'
    }) do
        require(tool).setup()
    end
end

return M
