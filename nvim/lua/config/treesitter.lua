local M = {}

local config = {
    yati = { enable = true },
    ensure_installed = { "c", "lua", "rust", "python", "vim", "toml", "bash", "comment", "rasi", "json",
        "jsonc", "cpp", "markdown" },
    sync_install = false,
    highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true
    },
}


function M.setup()
    local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
    if not ok then
        return false
    end

    treesitter.setup(config)
end

return M
