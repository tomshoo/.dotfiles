local parser_path = vim.fn.stdpath('data') .. '/lazy/nvim-treesitter/'
local treesitter_text_objects = {
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

local function setup(_, opts)
    local treesitter = require 'nvim-treesitter.configs'
    local ts_context = require 'treesitter-context'

    ts_context.setup {
        max_lines = 3,
        on_attach = function(bufnr)
            vim.keymap.set('n', '[c', ts_context.go_to_context, { silent = true, desc = "Go to context", buffer = bufnr })
            return true
        end
    }

    treesitter.setup(opts)
end

return {
    'nvim-treesitter/nvim-treesitter',
    config       = setup,
    build        = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    opts         = {
        sync_install       = false,
        highlight          = { enable = true, },
        textobjects        = treesitter_text_objects,
        parser_install_dir = parser_path,
    },
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'luckasRanarison/tree-sitter-hypr',
    },
}
