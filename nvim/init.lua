_G.version = vim.version()

require('utils')
require("maps")
require('plugins')
require("config")
require('aucmd')

vim.cmd [[
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
cnoreabbrev <expr> WQ ((getcmdtype() is# ':' && getcmdline() is# 'WQ')?('wq'):('WQ'))
cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))

" Configure backup and undo thingies
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "pset")
endif
]]

vim.opt.wrap       = false
vim.opt.wildmode   = "list:longest:full"
vim.opt.signcolumn = "yes:2"

vim.opt.fillchars:append("stlnc:·")

vim.opt.rtp:append(os.getenv("HOME") .. "/.config/nvim/")

vim.opt.guicursor = "r-v-c-sm:block,i-ci-ve:ver25,cr-o:hor21,n:hor10"

vim.opt.list = true
vim.opt.listchars:append({
    eol   = "⏎",
    tab   = "␉·",
    trail = "␠",
    nbsp  = "⎵",
})

vim.opt.ruler = true
vim.opt.list  = true

vim.opt.title       = true
vim.opt.showmode    = true
vim.opt.tabstop     = 4
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.expandtab   = true
vim.opt.shiftwidth  = 4
vim.opt.ignorecase  = true
vim.opt.hidden      = true
vim.opt.wildmenu    = true

vim.g.colorizer_startup = 1

-- For Conceal markers
if vim.fn.has('conceal')
then
    vim.opt.conceallevel  = 2
    vim.opt.concealcursor = "nvc"
end

-- Set cursorhold update time to a larger value to not make things messed up
vim.g.cursorhold_updatetime = 100

-- Disable netrw
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_netrwSettings     = 1
vim.g.loaded_netrwFileHandlers = 1

if vim.fn.exists('g:neovide') then
    require("ginit")
end
