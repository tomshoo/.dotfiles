local cfgpath = vim.fn.stdpath 'config'
vim.cmd.source(cfgpath .. '/rc.vim')

require 'plugins'
require 'config'
require 'lsp'
require 'keymaps'
