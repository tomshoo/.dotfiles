local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
        lazypath }
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
    { 'folke/which-key.nvim',      opts = {} },
    { 'kylechui/nvim-surround',    opts = {}, event = 'InsertEnter' },
    { 'windwp/nvim-autopairs',     opts = {}, event = 'InsertEnter' },
    { 'kevinhwang91/nvim-hlslens', opts = {} },
    { 'numToStr/Comment.nvim',     opts = {} },
    { 'lewis6991/gitsigns.nvim',   opts = {} },

    {
        'j-hui/fidget.nvim',
        opts = {},
        tag  = 'legacy'
    },

    require 'load.lualine',
    require 'load.nvim-tree',
    require 'load.aerial',
    require 'load.neorg',
    require 'load.treesitter',
    require 'load.telescope',
    require 'load.colorscheme',
    require 'load.completions',


    { 'kyazdani42/nvim-web-devicons', lazy = false },
    'nvim-lua/plenary.nvim',
    'folke/zen-mode.nvim',
    'direnv/direnv.vim',
    'antoinemadec/FixCursorHold.nvim',
    'godlygeek/tabular',
    'christoomey/vim-tmux-navigator',
    'norcalli/bclose.vim',
    'SmiteshP/nvim-navic',

    'mbbill/undotree',

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'jay-babu/mason-null-ls.nvim',
            'jose-elias-alvarez/null-ls.nvim',
            'ray-x/lsp_signature.nvim',
            'simrat39/rust-tools.nvim',
            'p00f/clangd_extensions.nvim',
            'folke/trouble.nvim',
            'folke/neodev.nvim',
        }
    },

    performance = {
        rtp = { path = { lazypath .. '/nvim-treesitter/' }, }
    }
}

require('lazy').setup(plugins, {
    lockfile = vim.fn.stdpath('data') .. '/lazy-lock.json'
})
