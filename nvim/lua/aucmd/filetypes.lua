CTable = {}

function CTable.setup()
    vim.cmd [[
    " Spectial keys for rust
    augroup RustKeys
        autocmd!
        autocmd FileType rust nnoremap <Leader>e :lua require('rust-tools.expand_macro').expand_macro()<CR>
        autocmd FileType rust nnoremap <Leader>i :lua require('rust-tools.inlay_hints').toggle_inlay_hints()<CR>
        autocmd FileType rust nnoremap <Leader>r :lua require('rust-tools.runnables').runnables()<CR>
        autocmd FileType rust nnoremap <Leader>h :lua require'rust-tools.hover_actions'.hover_actions()<CR>
    augroup END
    ]]
end

return CTable
