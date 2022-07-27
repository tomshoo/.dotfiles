vim.cmd [[packadd packer.nvim]]

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

local packer = require("packer")

return packer.startup({
    function(use)
        use 'wbthomason/packer.nvim'
        use "s1n7ax/nvim-terminal"
        use 'jghauser/mkdir.nvim'
        use "preservim/tagbar"
        use "preservim/vim-markdown"
        use "godlygeek/tabular"
        use 'xolox/vim-session'
        use 'xolox/vim-misc'
        use 'lifepillar/vim-colortemplate'
        use 'ryanoasis/vim-devicons'
        use 'lilydjwg/colorizer'
        use 'numToStr/Comment.nvim'
        use 'antoinemadec/FixCursorHold.nvim'
        use 'tpope/vim-fugitive'
        use 'rbgrouleff/bclose.vim'
        use 'folke/tokyonight.nvim'
        use 'lewis6991/gitsigns.nvim'
        use 'folke/which-key.nvim'
        use 'ahmedkhalf/project.nvim'
        use 'windwp/nvim-autopairs'
        use 'folke/trouble.nvim'
        use 'akinsho/toggleterm.nvim'
        use {
            'romgrk/barbar.nvim',
            requires = 'kyazdani42/nvim-web-devicons'
        }
        use {
            'goolord/alpha-nvim',
            requires = { 'kyazdani42/nvim-web-devicons' },
        }
        use {
            'nvim-telescope/telescope-frecency.nvim',
            requires = 'tami5/sqlite.lua',
        }
        use {
            'nvim-telescope/telescope.nvim',
            requires = 'nvim-lua/plenary.nvim',
        }
        use {
            'yioneko/nvim-yati',
            requires = 'nvim-treesitter/nvim-treesitter',
        }
        use {
            'simrat39/rust-tools.nvim',
        }
        use {
            "lukas-reineke/lsp-format.nvim",
        }
        use {
            'hrsh7th/cmp-nvim-lsp',
            requires = {
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-nvim-lua',
                'hrsh7th/cmp-cmdline',
                'hrsh7th/nvim-cmp',
                'dcampos/nvim-snippy',
                'dcampos/cmp-snippy'
            }
        }
        use {
            'neovim/nvim-lspconfig',
            requires = 'williamboman/nvim-lsp-installer'
        }
        use {
            'wfxr/minimap.vim',
            run = ':!cargo install --locked code-minimap'
        }
        use {
            'nvim-lualine/lualine.nvim',
            requires = 'kyazdani42/nvim-web-devicons'
        }
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ":TSUpdate",
        }
        use {
            "lukas-reineke/indent-blankline.nvim",
            after = "nvim-treesitter",
        }
        use {
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons"
        }
    end,
    config = {
        display = {
            open_fn = function()
                return require("packer.util").float({ border = 'rounded' })
            end
        }
    }
})
