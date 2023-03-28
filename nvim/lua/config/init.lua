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
        'Comment',
        'gitsigns',
        'which-key',
        'toggleterm',
        'scrollbar',
        'scrollbar.handlers.search',
        'config.colorscheme',
        'config.projects',
        'config.treesitter',
        'config.session',
        'config.telescope',
        'config.git',
        'config.autopairs',
        'config.nvimtree',
        'config.lualine',
        'config.bufferline',
        'config.dashboard',
        'config.indentguide',
        'config.trouble',
        'config.wilder',
        'config.ufo',
        'config.colorizer',
        'config.surround',
        'config.clipboard',
        'config.tmux',
    }) do
        pcall(function()
            require(plug).setup()
        end)
    end
end

-- Load everything
load_all()
