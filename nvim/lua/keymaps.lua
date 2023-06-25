_G.map = function(mode, key, action, opts)
    local options = {
        remap = false,
        silent = true
    }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, key, action, options)
end

map("n", "<Space>", "<Nop>")
vim.g.mapleader = " "

map('n', '<esc>', '<cmd>noh<cr>', { remap = true })
map('n', 'U', vim.cmd.redo, { remap = true })
map('n', 'gn', vim.cmd.BufferNext, { desc = "Go to next buffer" })
map('n', 'gp', vim.cmd.BufferPrevious, { desc = "Go to previous buffer" })

map('n', '<leader>y', '"+y')
map('n', '<leader>p', '"+p')
map('x', '<leader>P', '"_+dp')

map('n', '<leader>f', '<cmd>Telescope find_files<cr>', { desc = "Find files in current directory" })
map('n', '<leader>bl', '<cmd>Telescope buffers<cr>', { desc = "Find current active buffers" })
map('n', '<leader>Ff', '<cmd>Telescope frecency<cr>', { desc = "List frecently accessed files" })
map('n', '<leader>g', '<cmd>Telescope live_grep<cr>', { desc = "Live grep into files" })
