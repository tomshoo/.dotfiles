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

map('n', '<leader><leader>', vim.cmd.NvimTreeFindFileToggle, { desc = "Bring up file explorer" })
map('n', [[\\]], vim.cmd.UndotreeToggle, { desc = "Open Undo tree" })
map('n', [[\t]], vim.cmd.TroubleToggle, { desc = "Toggle workspace diagnostics" })
map('n', [[\r]], "<cmd>Telescope repo list<cr>", { desc = "List available git repositories" })

map('x', '<leader>y', '"+y')
map('n', '<leader>p', '"+p')
map('x', '<leader>P', '"_+dp')

map('n', '<leader>f', '<cmd>Telescope find_files<cr>', { desc = "Find files in current directory" })
map('n', '<leader>bl', '<cmd>Telescope buffers<cr>', { desc = "Find current active buffers" })
map('n', '<leader>Ff', '<cmd>Telescope frecency<cr>', { desc = "List frecently accessed files" })
map('n', '<leader>g', '<cmd>Telescope live_grep<cr>', { desc = "Live grep into files" })
map('n', '<leader>G', '<cmd>Telescope git_files<cr>', { desc = "Find git files" })
