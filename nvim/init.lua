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
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'windwp/nvim-autopairs'
Plugin 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}
Plugin 'lukas-reineke/indent-blankline.nvim'
Plugin 'navarasu/onedark.nvim'
Plugin 'godlygeek/tabular'
Plugin 'preservim/vim-markdown'
Plugin 'antoinemadec/FixCursorHold.nvim'
Plugin 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plugin 'mhinz/vim-startify'
Plugin 'vim-airline/vim-airline'
Plugin 'rbgrouleff/bclose.vim'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'preservim/nerdcommenter'
Plugin 'lambdalisue/fern.vim'
Plugin 'lilydjwg/colorizer'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'tpope/vim-fugitive'
Plugin 'ryanoasis/vim-devicons'
Plugin 'lambdalisue/nerdfont.vim'
Plugin 'lambdalisue/fern-renderer-nerdfont.vim'
Plugin 'elkowar/yuck.vim'
Plugin 'lifepillar/vim-colortemplate'
Plugin 'cocopon/iceberg.vim'
Plugin 'preservim/tagbar'
Plugin 'xolox/vim-session'
Plugin 'xolox/vim-misc'
Plugin 's1n7ax/nvim-terminal'
call vundle#end()

" Relative smartline
:set number
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

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

" Spectial keys for rust
augroup RustKeys
    autocmd!
    autocmd FileType rust nmap <Leader>e :vsplit<CR> :CocCommand rust-analyzer.expandMacro<CR>
augroup END

" Fern tree key bindings
function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <plug>(fern-my-open-expand-collapse)
  nmap <buffer> e <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> h <Plug>(fern-action-hidden:toggle)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> <Space> <Plug>(fern-action-mark-toggle)
  nmap <buffer> N <Plug>(fern-action-new-path)
  nmap <buffer> M <Plug>(fern-action-rename)
  nmap <buffer> <Enter> <Plug>(fern-action-enter)
  nmap <buffer> <BS> <Plug>(fern-action-leave)
  nmap <buffer> o <Plug>(fern-action-open)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> S <Plug>(fern-action-open:vsplit)
  nmap <buffer> t <Plug>(fern-action-open:tabedit)
  nmap <buffer> O <Plug>(fern-action-open:select)
  nmap <buffer> d <Plug>(fern-action-trash)
  nmap <buffer> D <Plug>(fern-action-remove)
  nmap <buffer> ~ <Plug>(fern-action-terminal)
endfunction

augroup FernGroup
    autocmd!
    autocmd FileType fern call FernInit()
augroup END

set guicursor=v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor21,n:hor10
function! s:hijack_directory() abort
  let path = expand('%:p')
  if !isdirectory(path)
    return
  endif
  bwipeout %
  execute printf('Fern %s', fnameescape(path))
endfunction

augroup my_fern_hijack
  autocmd!
  autocmd BufEnter * ++nested call s:hijack_directory()
augroup END
]]
-- Imports
local onedark           = require("onedark")
local autopairs         = require("nvim-autopairs")
local treesitter_config = require("nvim-treesitter.configs")
local nvterm            = require("nvim-terminal")
local indentguide       = require("indent_blankline")

indentguide.setup ({
    show_current_context = true,
    show_current_context_start = true,
    space_char_blankline = " ",
    show_end_of_line = true
})

nvterm.setup()

onedark.setup ({
    style = "darker",
    transparent = true,
})
onedark.load()

autopairs.setup({
    disable_filetype = {
            "fern",
            "vim",
            "scratch",
            "nofile"
        },
    check_ts = true,
    }
)

-- Configure vim airline
vim.g.airline_theme="onedark"
vim.g["airline#extensions#tabline#enabled"] = 1
if not vim.fn.exists("g:airline_symbols")
then
    vim.g["airline_symbols"] = {
        space = "\\ua0",
        colnr = ' '
    }
end

vim.opt.list = true
vim.opt.listchars:append("eol:⏎")
vim.opt.listchars:append("tab:␉·")
vim.opt.listchars:append("trail:␠")
vim.opt.listchars:append("nbsp:⎵")
vim.opt.listchars:append("space:·")

vim.opt.ruler           = true
vim.opt.mouse           = "a"
vim.opt.list            = true

vim.opt.title           = true
vim.opt.showmode        = true
vim.opt.tabstop         = 4
vim.opt.smartindent     = true
vim.opt.softtabstop     = 4
vim.opt.expandtab       = true
vim.opt.shiftwidth      = 4
vim.opt.ignorecase      = true
vim.opt.hidden          = true
vim.opt.wildmenu        = true

vim.g.colorizer_startup = 1

-- For Conceal markers
if vim.fn.has('conceal')
then
    vim.opt.conceallevel = 2
    vim.opt.concealcursor="niv"
end

-- Fern extra settings
vim.g["fern#disable_default_mappings"] = 1
vim.g["fern#renderer"]                 = "nerdfont"

-- Vim session settings
vim.g.session_autosave                 = "no"
vim.g.session_autoload                 = "yes"
vim.g.minimap_auto_start               = 1
vim.g.minimap_git_colors               = 1

-- Some thing I had in my old config dont really remember why
vim.g.cursorhold_updatetime            = 100

-- Disable netrw
vim.g.loaded_netrw                     = 1
vim.g.loaded_netrwPlugin               = 1
vim.g.loaded_netrwSettings             = 1
vim.g.loaded_netrwFileHandlers         = 1

-- Configure minimap
vim.g.minimap_block_filetypes = {
    "startify",
    "fern",
    "vundle",
    "tagbar",
}
vim.g.minimap_block_filetypes = {
    "fugitive",
    "fern",
    "vundle",
    "ale-fix-suggest"
}
vim.g.minimap_close_bufftypes = {
    "nofile",
    "terminal",
    "prompt",
    "quickfix",
    "nowrite"
}
vim.g.startify_session_before_save = {
    "TagbarClose",
    "MinimapClose",
    "FernDo quit"
}

-- Configure treesitter
treesitter_config.setup {
  ensure_installed = { "c", "lua", "rust", "python", "vim" },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  }
}

-- Function to map key bindings in lua
function map(mode, key, action, opts)
    local options = { noremap = true }
    if opts
        then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, key, action, options)
end

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

-- Configure keybinds
map("n" , "<S-h>"        , "<C-w>h"                                          , { noremap = false })
map("n" , "<S-j>"        , "<C-w>j"                                          , { noremap = false })
map("n" , "<S-k>"        , "<C-w>k"                                          , { noremap = false })
map("n" , "<S-l>"        , "<C-w>l"                                          , { noremap = false })

map("n" , "<Leader>sv"   , "<C-w>v"                                          , { noremap = false })
map("n" , "<Leader>sh"   , "<C-w>h"                                          , { noremap = false })

map("n" , "<Leader>wn"   , ":w <bar> bn<CR>")
map("n" , "<Leader>wp"   , ":w <bar> bp<CR>")

map("n" , "<Leader>bn"   , ":bn<CR>")
map("n" , "<Leader>bp"   , ":bp<CR>")
map("n" , "<Leader>bq"   , ":bd<CR>")
map("n" , "<Leader>bQ"   , ":bw<CR>")

map("n" , "<Leader>u"    , ":TSToggle highlight<CR>"                         , { silent = true })
map("n" , "<F3>"         , ":TagbarToggle<CR>"                               , { silent = true })
map("n" , "<F4>"         , ":MinimapToggle<CR>"                              , { silent = true })
map("n" , "<Leader><F4>" , ":MinimapRescan<CR> :MinimapRefresh<CR>"          , { silent = true })

map("n" , "<F2>"         , ":Fern . -drawer -toggle -width=30<CR>"           , { silent = true })
map("n" , "<Leader><F2>" , ":Fern . -drawer -toggle -width=30 -reveal=%<CR>" , { silent = true })

map("n" , "<Home>"       , ":lua ExtendedHome()<CR>"                         , { silent = true })
map("i" , "<Home>"       , "<C-O>:lua ExtendedHome()<CR>"                    , { silent = true })

map("n" , "<Leader>s"    , ":lua Scratch()<CR>"                              , { silent = true })


-- Some more vim only keybinds
vim.cmd [[
if exists('g:neovide')
    so ~/.config/nvim/ginit.lua
endif
]]
