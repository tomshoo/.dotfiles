local M = {}

local cfg = {
    options = {
        mode = "buffers",
        offsets = {
            {
                filetype = "NvimTree",
                text = "Explorer",
                text_align = "left"
            },
            {
                filetype = "minimap",
                text = ""
            }
        }
    },
}

function M.setup()
    local ok, bufferline = pcall(require, 'bufferline')
    if not ok then
        return false
    end

    bufferline.setup(cfg)
end

return M
