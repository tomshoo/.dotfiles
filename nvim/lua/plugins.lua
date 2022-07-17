vim.cmd [[packadd packer.nvim]]

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

return require('packer').startup(
    function(use)
        use 'wbthomason/packer.nvim'
        use "s1n7ax/nvim-terminal"
        use "preservim/tagbar"
        use "preservim/vim-markdown"
        use "godlygeek/tabular"
        use "mhinz/vim-startify"
        use 'xolox/vim-session'
        use 'xolox/vim-misc'
        use 'lifepillar/vim-colortemplate'
        use 'ryanoasis/vim-devicons'
        use 'lilydjwg/colorizer'
        use 'preservim/nerdcommenter'
        use 'antoinemadec/FixCursorHold.nvim'
        use 'tpope/vim-fugitive'
        use 'rbgrouleff/bclose.vim'
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
                        { name = 'buffer' }
                    }
                }
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
            tag = 'v2.*',
            config = function() require("toggleterm").setup {}
            end
        }
        use {
            'wfxr/minimap.vim',
            run = ':!cargo install --locked code-minimap'
        }
        use {
            'vim-airline/vim-airline',
            requires = 'vim-airline/vim-airline-themes'
        }
        use {
            'navarasu/onedark.nvim',
            config = function()
                if vim.fn.exists('g:neovide') == 1 then
                    require('onedark').setup {
                        transparent = false,
                        style = 'deep'
                    }
                else
                    require("onedark").setup {
                        transparent = true,
                        style = "darker"
                    }
                end
                require('onedark').load()
            end
        }
        use {
            'windwp/nvim-autopairs',
            config = function() require("nvim-autopairs").setup {
                    disable_filetype = {
                        "scratch",
                        "nofile"
                    },
                    check_ts = true,
                }
            end
        }
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ":TSUpdate",
            event = { "BufEnter", "BufNewFile", "BufRead" },
            config = function() require("nvim-treesitter.configs").setup {
                    yati = { enable = true },
                    ensure_installed = { "c", "lua", "rust", "python", "vim" },
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
            end
        }
        use {
            "lukas-reineke/indent-blankline.nvim",
            after = "nvim-treesitter",
            config = function() require("indent_blankline").setup {
                    show_current_context = true,
                    show_current_context_start = true,
                    space_char_blankline = " ",
                    show_end_of_line = true,
                    filetype_exclude = {
                        "startify"
                    }
                }
            end
        }
        use {
            "kyazdani42/nvim-tree.lua",
            requires = {
                "kyazdani42/nvim-web-devicons"
            },
            config = function() require("nvim-tree").setup {
                    disable_netrw = true,
                    hijack_netrw = true,
                    auto_reload_on_write = true,
                    open_on_tab = true,
                    hijack_cursor = true,
                    sync_root_with_cwd = true,
                    reload_on_bufenter = true,
                    respect_buf_cwd = true,
                    filters = {
                        dotfiles = true
                    },
                    git = {
                        show_on_dirs = true
                    },
                    view = {
                        side = "left",
                        width = 35,
                        signcolumn = "auto"
                    },
                    renderer = {
                        group_empty = true,
                        highlight_opened_files = "icon",
                        indent_markers = {
                            enable = true
                        },
                        icons = {
                            git_placement = "after",
                            show = {
                                folder_arrow = false
                            }
                        }
                    }
                }
            end
        }
    end
)
