function! s:alias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

call s:alias('bc', 'BufferClose')
call s:alias('W',  'write')
call s:alias('Q',  'quit')
call s:alias('Wq', 'wq')
call s:alias('trim', '%s/\s\+$// | noh')

set number
set undofile
set nowrap
set list
set ruler
set title
set noshowmode
set smartindent
set expandtab
set ignorecase
set hidden
set wildmenu
set cursorline

set wildmode=list:longest:full
set signcolumn=yes:2
set tabstop=4
set softtabstop=4
set shiftwidth=4
set scrolloff=5
set cmdheight=0

if has('conceal')
  set conceallevel=2
  set concealcursor=nvc
endif

if has('termguicolors')
  set termguicolors
endif

autocmd! BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != 'i' | set rnu | endif
autocmd! BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif

let g:cursorhold_updatetime=100

let g:sonokai_transparent_background=1
let g:sonokai_dim_inactive_windows=1
let g:sonokai_show_eob=1
let g:sonokai_diagnostic_line_highlight=1
let g:sonokai_diagnostic_text_highlight=1

colorscheme sonokai
