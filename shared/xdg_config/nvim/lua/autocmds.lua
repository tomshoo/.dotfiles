vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group    = vim.api.nvim_create_augroup('Mkdir', { clear = true }),
    callback = function()
        local dir = vim.fn.expand('<afile>:p:h')

        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, 'p')
        end
    end
})

vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
    group    = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})
