local M = {}

local cfg = {
    width = 20,
    auto_close = true,
    auto_preview = true,
    symbols = {
        File = { icon = " ", hl = "TSURI" },
        Module = { icon = " ", hl = "TSNamespace" },
        Namespace = { icon = "", hl = "TSNamespace" },
        Package = { icon = "", hl = "TSNamespace" },
        Class = { icon = " ", hl = "TSType" },
        Method = { icon = " ", hl = "TSMethod" },
        Property = { icon = " ", hl = "TSMethod" },
        Field = { icon = " ", hl = "TSField" },
        Constructor = { icon = " ", hl = "TSConstructor" },
        Enum = { icon = " ", hl = "TSType" },
        Interface = { icon = " ", hl = "TSType" },
        Function = { icon = " ", hl = "TSFunction" },
        Variable = { icon = "", hl = "TSConstant" },
        Constant = { icon = " ", hl = "TSConstant" },
        String = { icon = "𝓐", hl = "TSString" },
        Number = { icon = "#", hl = "TSNumber" },
        Boolean = { icon = "⊨", hl = "TSBoolean" },
        Array = { icon = "", hl = "TSConstant" },
        Object = { icon = "⦿", hl = "TSType" },
        Key = { icon = "🔐", hl = "TSType" },
        Null = { icon = "NULL", hl = "TSType" },
        EnumMember = { icon = " ", hl = "TSField" },
        Struct = { icon = " ", hl = "TSType" },
        Event = { icon = " ", hl = "TSType" },
        Operator = { icon = " ", hl = "TSOperator" },
        TypeParameter = { icon = " ", hl = "TSParameter" }
    }
}

function M.setup()
    local ok, symbols = pcall(require, 'symbols-outline')
    if not ok then
        return false
    end
    symbols.setup(cfg)
    return true
end

return M
