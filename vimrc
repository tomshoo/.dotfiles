syntax on
set tabstop=4
filetype plugin indent on
syntax on
set nu
set ruler
set mouse=a
set list
set listchars=tab:\ \ 

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'mhinz/vim-startify'
Plugin 'itchyny/lightline.vim'
Plugin 'preservim/nerdcommenter'
Plugin 'lilydjwg/colorizer'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
call vundle#end()

set nowrap
set statusline=%{getcwd()}\/\%f%=%-14.(%l,%c%V%)\ %P
set title
set nocursorline
set nocompatible
set showmode
set tabstop=4
set t_Co=256
set smartindent
set softtabstop=4
set ignorecase
set hidden
set wildmenu
set wildmode=list:longest:full

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
    call mkdir(expand(&directory), "p")
endif

:inoremap ( ()<Esc>i
:inoremap { {}<Esc>i
:inoremap [ {}<Esc>i
:inoremap ' ''<Esc>i
:inoremap " ""<Esc>i
:inoremap ` ``<Esc>i

au WinLeave * set nocursorline
au WinEnter * set cursorline
set cursorline

let g:colorizer_startup=1

let g:lightline = {
	\ 'colorscheme' : 'nord'
\}
