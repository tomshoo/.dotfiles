require('plugins')
require('aucmd')
require("maps")
require("config")

vim.cmd [[
let $PATH .= ":/home/gh0st/.cargo/bin/"
syntax on
filetype plugin indent on

cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
cnoreabbrev <expr> WQ ((getcmdtype() is# ':' && getcmdline() is# 'WQ')?('wq'):('WQ'))
cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))

au WinLeave * set nocursorline
au WinEnter * set cursorline
set cursorline

set fillchars+=stl:\ ,stlnc:\

set rtp+=~/.config/nvim/

" Settings that are deprecated
set nowrap
set noshowmode
set nocompatible
set t_Co=256
set wildmode=list:longest:full

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


set guicursor=v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor21,n:hor10
]]
-- Configure vim airline
vim.g.airline_theme = "onedark"
vim.g["airline#extensions#tabline#enabled"] = 1
if not vim.fn.exists("g:airline_symbols")
then
    vim.g["airline_symbols"] = {
        space = "  ",
        colnr = ' '
    }
end

vim.opt.list = true
vim.opt.listchars:append("eol:⏎")
vim.opt.listchars:append("tab:␉·")
vim.opt.listchars:append("trail:␠")
vim.opt.listchars:append("nbsp:⎵")
vim.opt.listchars:append("space:·")

vim.opt.ruler = true
vim.opt.mouse = "a"
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
    vim.opt.conceallevel = 2
    vim.opt.concealcursor = "niv"
end

-- Fern extra settings
vim.g["fern#disable_default_mappings"] = 1
vim.g["fern#renderer"]                 = "nerdfont"

-- Vim session settings
vim.g.session_autosave   = "no"
vim.g.session_autoload   = "yes"
vim.g.minimap_auto_start = 1
vim.g.minimap_git_colors = 1

-- Some thing I had in my old config dont really remember why
vim.g.cursorhold_updatetime = 100

-- Disable netrw
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_netrwSettings     = 1
vim.g.loaded_netrwFileHandlers = 1

-- Configure minimap
vim.g.minimap_block_filetypes = {
    "startify",
    "tagbar",
    "ale-fix-suggest",
    "fugitive",
    "NvimTree",
    "help",
    "scratch",
    "dashboard",
    ""
}

vim.g.minimap_block_buftypes = {
    "terminal",
    "startify",
    "dashboard",
    "nofile"
}

vim.g.minimap_close_buftypes = {
    "nofile",
    "terminal",
    "prompt",
    "quickfix",
    "dashboard",
    "nowrite",
}
vim.g.startify_session_before_save = {
    "TagbarClose",
    "MinimapClose",
    "NvimTreeClose"
}

-- VSCode like Home key
function ExtendedHome()
    local column = vim.fn.col('.')
    vim.cmd "normal! ^"
    if column == vim.fn.col('.')
    then
        vim.cmd "normal! 0"
    end
end

-- Launch Scratchpad to well.. scratch
function Scratch()
    vim.cmd [[
    split
    noswapfile hide enew
    setlocal buftype=nofile
    setlocal bufhidden=hide
    file scratch
    ]]
end

if vim.fn.exists('g:neovide') then
    require("ginit")
end
