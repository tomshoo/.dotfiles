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
            after = "nvim-treesitter"
        }
        use {
            'simrat39/rust-tools.nvim',
            requires = 'neovim/nvim-lspconfig',
            config = function()
                require('rust-tools').setup {
                    autoSetHints = true,
                    server = {
                        standalone = false
                    }
                }
            end
        }
        use {
            "lukas-reineke/lsp-format.nvim",
            after = "cmp-nvim-lsp",
            config = function()
                require("lsp-format").setup {}
                local abilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
                require("lsp").setup(abilities)
            end
        }
        use {
            'folke/trouble.nvim',
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                local trouble = require('trouble')
                trouble.setup {
                    indent_lines = true,
                    fold_closed = ">>+",
                    signs = {
                        error = "[error]",
                        warning = "[warn]",
                        hint = "[help]",
                        information = "[info]"
                    },
                    use_diagnostic_signs = false
                }
            end
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
            },
            after = {
                "nvim-lspconfig",
            },
            config = function()
                local cmp = require("cmp")
                local snippy = require("snippy")
                cmp.setup {
                    enabled = function()
                        local context = require("cmp.config.context")
                        if vim.api.nvim_get_mode().mode == 'c' then
                            return true
                        else
                            return not context.in_treesitter_capture("comment") and
                                not context.in_syntax_group("Comment")
                        end
                    end,
                    snippet = {
                        expand = function(args) snippy.expand_snippet(args.body)
                        end
                    },
                    mapping = cmp.mapping.preset.insert({
                        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-f>'] = cmp.mapping.scroll_docs(4),
                        ['<C-Space>'] = cmp.mapping.complete(),
                        ['<C-e>'] = cmp.mapping.abort(),
                        ['<CR>'] = cmp.mapping.confirm({ select = true }),
                        ['<Up>'] = cmp.mapping.select_prev_item(),
                        ['<Down>'] = cmp.mapping.select_next_item(),
                        ['<Tab>'] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            elseif snippy.can_expand_or_advance() then
                                snippy.expand_or_advance()
                            else
                                fallback()
                            end
                        end),
                        ['<S-Tab>'] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item()
                            elseif snippy.can_jump(-1) then
                                snippy.jump(-1)
                            else
                                fallback()
                            end
                        end)
                    }),
                    sources = {
                        { name = 'snippy' },
                        { name = 'nvim_lsp' },
                        { name = 'path' },
                        { name = 'buffer' },
                        { name = 'nvim_lua' },
                    }
                }
                cmp.setup.cmdline(':', {
                    mapping = cmp.mapping.preset.insert({
                        ['<C-Up>'] = cmp.mapping.select_prev_item(),
                        ['<C-Down>'] = cmp.mapping.select_next_item(),
                    }),
                    sources = { { name = 'cmdline' } }
                })

                cmp.setup.cmdline('/', {
                    sources = { { name = 'buffer' } }
                })
            end
        }
        use {
            'neovim/nvim-lspconfig',
            requires = 'williamboman/nvim-lsp-installer',
            config = function()
                local lsp_installer = require("nvim-lsp-installer")
                lsp_installer.setup {
                    automatic_installation = true
                }
            end
        }
        use {
            'akinsho/toggleterm.nvim',
            config = function() require("toggleterm").setup {}
            end
        }
        use {
            'wfxr/minimap.vim',
            run = ':!cargo install --locked code-minimap'
        }
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true }
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
            requires = {
                "kyazdani42/nvim-web-devicons"
            },
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
