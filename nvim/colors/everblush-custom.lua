local cfg = {}

local function setup()
    local ok, everblush = pcall(require, 'everblush')
    if not ok then
        vim.cmd [[ colorscheme default ]]
        return false
    end

    everblush.setup(cfg)
    return true
end

if setup() then
    local hl = vim.api.nvim_set_hl
    hl(0, "TreesitterContext", { bg = "#2a3033" })
    hl(0, "Folded", { bg = "#2a3033" })
    hl(0, "LineNr", { fg = "#b3b9b8" })
end
