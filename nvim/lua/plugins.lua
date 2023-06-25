local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    }
end

vim.cmd [[packadd packer.nvim]]

vim.cmd [[
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]]

local packer = require('packer')

local plugins = {
    'wbthomason/packer.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'kevinhwang91/nvim-hlslens',
    'godlygeek/tabular',
    'christoomey/vim-tmux-navigator',
    'gelguy/wilder.nvim',
    'folke/which-key.nvim',

    'mbbill/undotree',
    'TimUntersberger/neogit',
    'lewis6991/gitsigns.nvim',

    'kyazdani42/nvim-web-devicons',
    'romgrk/barbar.nvim',
    'nvim-lualine/lualine.nvim',

    'windwp/nvim-autopairs',
    'kylechui/nvim-surround',
    'numToStr/Comment.nvim',

    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'jay-babu/mason-null-ls.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'ray-x/lsp_signature.nvim',
    'simrat39/rust-tools.nvim',
    'folke/trouble.nvim',
    'folke/neodev.nvim',
    'SmiteshP/nvim-navic',
    { 'j-hui/fidget.nvim', tag = 'legacy' },

    'hrsh7th/nvim-cmp',
    'dcampos/nvim-snippy',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lua',
    'dcampos/cmp-snippy',
    'Saecki/crates.nvim',

    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-textobjects',

    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-telescope/telescope-frecency.nvim',
    'kkharji/sqlite.lua',

    'sainnhe/sonokai',
}

return packer.startup({
    function(use)
        for _, plugin in ipairs(plugins) do
            use(plugin)
        end
        if PACKER_BOOTSTRAP then
            packer.sync()
        end
    end
})
