_G.__luacache_config = {
    chunks = {
        enable = true,
        path = vim.fn.stdpath('cache') .. '/luacache_chunk'
    },
    modpaths = {
        enabled = true,
        path = vim.fn.stdpath('cache') .. '/luacache_modpaths'
    }
}

require('impatient')

local plug_table = {
    "Comment",
    "gitsigns",
    "which-key",
    "project_nvim",
    "toggleterm",
    "scrollbar",
}

local function load_all()
    for _, plug in ipairs(plug_table) do
        local ok, loader = pcall(require, plug)
        if ok then
            loader.setup()
        end
    end
end

-- Load everything
require('config.treesitter').setup()
require('config.session').setup()
require('config.telescope').setup()
require('config.lsp').setup()
require('config.git').setup()
require('config.autopairs').setup()
require('config.colorscheme').setup()
require('config.nvimtree').setup()
require('config.lualine').setup()
require('config.bufferline').setup()
require('config.dashboard').setup()
require('config.indentguide').setup()
require('config.trouble').setup()
require('config.wilder').setup()

load_all()

local signs = {
    Error = " ",
    Warning = " ",
    Hint = " ",
    Information = " "
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {
        text = icon,
        texthl = hl,
        numhl = ""
    })
end
