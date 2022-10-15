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

local function load_all()
    for _, plug in ipairs({
        'config.colorscheme',
        'Comment',
        'gitsigns',
        'which-key',
        'project_nvim',
        'toggleterm',
        'scrollbar',
        'scrollbar.handlers.search',
        'indent-o-magic',
        'config.treesitter',
        'config.session',
        'config.telescope',
        'config.lsp',
        'config.git',
        'config.autopairs',
        'config.nvimtree',
        'config.lualine',
        'config.bufferline',
        'config.dashboard',
        'config.indentguide',
        'config.trouble',
        'config.wilder',
        'config.org',
        'config.ufo',
        'config.colorizer',
        'config.toggler',
        'config.surround',
        'config.clipboard',
        'config.tmux',
        'twilight'
    }) do
        local ok, loader = pcall(require, plug)
        if ok then
            loader.setup()
        end
    end
end

-- Load everything
load_all()
