vim.cmd [[
function! s:alias(from, to)
    exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

call s:alias('bc',  'BufferClose')
call s:alias('W',   'write')
call s:alias('Q',   'quit')
call s:alias('Wq',  'wq')
call s:alias('git', 'Neogit')
]]


vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1


vim.g.cursorhold_updatetime = 100


vim.g.sonokai_dim_inactive_windows      = 1
vim.g.sonokai_enable_italic             = 1
vim.g.sonokai_disable_italic_comment    = 1
vim.g.sonokai_sho_eob                   = 1
vim.g.sonokai_diagnostic_line_highlight = 1
vim.g.sonokai_diagnostic_text_highlight = 1

if vim.fn.has('g:neovide') then
    vim.g.sonokai_transparent_background = 1
end

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
vim.opt.scrolloff   = 5
vim.opt.mouse       = 'nv'
vim.opt.mousescroll = 'ver:0,hor:0'

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

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = vim.api.nvim_create_augroup('Mkdir', { clear = true }),
    callback = function()
        local dir = vim.fn.expand('<afile>:p:h')
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, 'p')
        end
    end
})

for _, mod in ipairs({
    'plugins',
    'config',
    'lsp',
    'keymaps',
}) do
    local _, ok = pcall(require, mod)
    if not ok then
        vim.print('Failed loading module', mod)
    end
end

local _, ok = pcall(vim.cmd.colorscheme, 'sonokai')
if not ok then vim.cmd.colorscheme 'elflord' end
