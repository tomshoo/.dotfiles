local M = {}

local function rusttools()
    local ok, tool = pcall(require, 'rust-tools')
    if not ok then
        return
    end

    tool.setup {
        autoSetHints = true,
        server = {
            standalone = false
        }
    }
end

function M.setup()
    rusttools()
end

return M
