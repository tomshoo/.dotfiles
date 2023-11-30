_G.keymaps = {
    keymaps = {},
    default_opts = {},
}

function _G.mapkey(mode, key, action, opts)
    local default_opts = {
        remap  = true,
        silent = true
    }

    opts = vim.tbl_extend('keep', opts or {}, default_opts)
    vim.keymap.set(mode, key, action, opts)
end

vim.keymap.set("n", "<Space>", "<Nop>")
vim.g.mapleader = " "

mapkey('n', '<esc>', '<cmd>noh<cr>', { remap = true })

mapkey('n', 'U', vim.cmd.redo, { remap = true })

mapkey('n', 'gn', vim.cmd.bnext, { desc = "Go to next buffer" })
mapkey('n', 'gp', vim.cmd.bprevious, { desc = "Go to previous buffer" })

mapkey('n', 'j', 'gj')
mapkey('n', 'k', 'gk')

mapkey('n', '<leader><leader>', vim.cmd.NvimTreeFindFileToggle, { desc = "Bring up file explorer" })
mapkey('n', [[\\]], vim.cmd.UndotreeToggle, { desc = "Open Undo tree" })
mapkey('n', [[\t]], vim.cmd.TroubleToggle, { desc = "Toggle workspace diagnostics" })

mapkey('x', '<leader>y', '"+y')
mapkey('n', '<leader>p', '"+p')
mapkey('x', '<leader>P', '"_+dp')

mapkey('n', [[\r]], "<cmd>Telescope repo list<cr>", { desc = "List available git repositories" })
mapkey('n', '<leader>f', '<cmd>Telescope find_files<cr>', { desc = "Find files in current directory" })
mapkey('n', '<leader>b', '<cmd>Telescope buffers<cr>', { desc = "Find current active buffers" })
mapkey('n', '<leader>Ff', '<cmd>Telescope frecency<cr>', { desc = "List frecently accessed files" })
mapkey('n', '<leader>g', '<cmd>Telescope live_grep<cr>', { desc = "Live grep into files" })
mapkey('n', '<leader>G', '<cmd>Telescope git_files<cr>', { desc = "Find git files" })

vim.keymap.set('n', [[\z]], function() require('zen-mode').toggle {} end, { desc = "Toggle zen mode" })
