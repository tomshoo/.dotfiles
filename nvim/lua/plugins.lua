local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    })
end

vim.cmd [[packadd packer.nvim]]

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

local packer = require("packer")

packer.init({

    display = {
        open_fn = function()
            return require("packer.util").float({ border = 'rounded' })
        end
    }
})

return packer.startup({
    function(use)
        use 'lewis6991/impatient.nvim'
        use 'olimorris/persisted.nvim'
        use 'wbthomason/packer.nvim'
        use "s1n7ax/nvim-terminal"
        use 'jghauser/mkdir.nvim'
        use "preservim/tagbar"
        use "preservim/vim-markdown"
        use "godlygeek/tabular"
        use 'xolox/vim-misc'
        use 'lifepillar/vim-colortemplate'
        use 'ryanoasis/vim-devicons'
        use 'lilydjwg/colorizer'
        use 'numToStr/Comment.nvim'
        use 'antoinemadec/FixCursorHold.nvim'
        use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
        use 'rbgrouleff/bclose.vim'
        use 'folke/tokyonight.nvim'
        use 'lewis6991/gitsigns.nvim'
        use 'folke/which-key.nvim'
        use 'ahmedkhalf/project.nvim'
        use 'windwp/nvim-autopairs'
        use 'folke/trouble.nvim'
        use 'akinsho/toggleterm.nvim'
        use 'kyazdani42/nvim-web-devicons'
        use 'romgrk/barbar.nvim'
        use "kyazdani42/nvim-tree.lua"
        use 'goolord/alpha-nvim'
        use 'simrat39/rust-tools.nvim'
        use "lukas-reineke/lsp-format.nvim"
        use 'nvim-lualine/lualine.nvim'
        use 'kosayoda/nvim-lightbulb'
        use 'gelguy/wilder.nvim'
        use 'petertriho/nvim-scrollbar'
        use {
            'nvim-telescope/telescope.nvim',
            requires = 'nvim-lua/plenary.nvim',
        }
        use {
            'nvim-telescope/telescope-frecency.nvim',
            requires = 'tami5/sqlite.lua',
        }
        use {
            'yioneko/nvim-yati',
            requires = 'nvim-treesitter/nvim-treesitter',
        }
        use {
            'hrsh7th/cmp-nvim-lsp',
            requires = {
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-nvim-lua',
                'hrsh7th/nvim-cmp',
                'dcampos/nvim-snippy',
                'dcampos/cmp-snippy',
                'onsails/lspkind.nvim'
            }
        }
        use {
            'neovim/nvim-lspconfig',
            requires = 'williamboman/nvim-lsp-installer'
        }
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ":TSUpdate",
        }
        use {
            "lukas-reineke/indent-blankline.nvim",
            after = "nvim-treesitter",
        }


        if PACKER_BOOTSTRAP then
            require('packer').sync()
        end
    end
})
