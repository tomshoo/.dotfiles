local tsitter = require 'nvim-treesitter.configs'
local tsctxt  = require 'treesitter-context'


local tstextobjects = {
    ['select'] = {
        enable    = true,
        lookahead = true,

        keymaps   = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ib"] = "@block.inner",
            ["ab"] = "@block.outer"
        }
    }
}


tsctxt.setup {
    max_lines = 3,
    on_attach = function(bufnr)
        map('n', '[c', tsctxt.go_to_context, {
            silent = true,
            desc = "Go to context",
            buffer = bufnr
        })
    end
}

tsitter.setup {
    highlight = {
        enable   = true,
        disabled = { 'bash', }
    },
    textobjects = tstextobjects,
}
