local M = {}

local config = {
    yati = { enable = true },
    ensure_installed = {
        "c",
        "lua",
        "rust",
        "python",
        "vim",
        "toml",
        "bash",
        "comment",
        "rasi",
        "json",
        "jsonc",
        "cpp",
        "markdown",
    },
    sync_install = false,
    highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = true,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,

            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ib"] = "@block.inner",
                ["ab"] = "@block.outer"
            }
        }
    },
    rainbow = {
        enable = true,
        extend_mode = true,
        colors = {
            "#67b0e8",
            "#6cbfbf",
            "#8ccf7e",
            "#e5c76b",
            "#e57474"
        }
    }
}

local tsccfg = {
}

local function tscsetup()
    local ok, tscontext = pcall(require, 'treesitter-context')
    if ok then
        tscontext.setup(tsccfg)
    end
end

function M.setup()
    local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
    if not ok then
        return false
    end

    tscsetup()
    treesitter.setup(config)
end

return M
