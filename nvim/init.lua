vim.cmd [[
function! s:alias(from, to)
    exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction
call s:alias('bc',  'Bclose')
call s:alias('W',   'write')
call s:alias('Q',   'quit')
call s:alias('Wq',  'wq')
]]

vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1


vim.g.cursorhold_updatetime = 100
vim.g.undotree_WindowLayout = 2


vim.opt.number      = true
vim.opt.undofile    = true
vim.opt.list        = true
vim.opt.ruler       = true
vim.opt.title       = true
vim.opt.smartindent = true
vim.opt.expandtab   = true
vim.opt.ignorecase  = true
vim.opt.hidden      = true
vim.opt.wildmenu    = true
vim.opt.cursorline  = true


vim.opt.wrap     = false
vim.opt.showmode = false


vim.opt.wildmode    = 'list:longest:full'
vim.opt.signcolumn  = 'yes:2'
vim.opt.tabstop     = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth  = 4
vim.opt.scrolloff   = 10
vim.opt.mouse       = 'nv'
vim.opt.mousescroll = 'ver:0,hor:0'
vim.opt.guicursor   = 'n-v-c-i:block'

if vim.fn.has('conceal') == 1 then
    vim.opt.conceallevel  = 2
    vim.opt.concealcursor = 'nvc'
end


if vim.fn.has('termguicolors') == 1 then
    vim.opt.termguicolors = true
end


vim.cmd [[
augroup NumberLine
    autocmd!
    autocmd! BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != 'i' | set rnu | endif
    autocmd! BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END
]]

require 'keymaps'
require 'plugins'
require 'load.lsp'
require 'autocmds'
require 'commands'
