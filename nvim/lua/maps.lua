local map = function(mode, key, action, opts)
    local options = {
        noremap = true,
        silent = true
    }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, key, action, options)
end

local function set()
    map("n", "<S-h>", "<C-w>h", { noremap = false })
    map("n", "<S-j>", "<C-w>j", { noremap = false })
    map("n", "<S-k>", "<C-w>k", { noremap = false })
    map("n", "<S-l>", "<C-w>l", { noremap = false })

    map("n", "<Leader>sv", "<C-w>v", { noremap = false })
    map("n", "<Leader>sh", "<C-w>h", { noremap = false })

    map("n", "<Leader>wn", ":w <bar> bn<CR>")
    map("n", "<Leader>wp", ":w <bar> bp<CR>")

    map("n", "<Leader>bn", ":bn<CR>")
    map("n", "<Leader>bp", ":bp<CR>")
    map("n", "<Leader>bq", ":bd<CR>")
    map("n", "<Leader>bQ", ":bw<CR>")

    map("n", "<Leader>u", ":TSToggle highlight<CR>")
    map("n", "<F3>", ":TagbarToggle<CR>")
    map("n", "<F4>", ":MinimapToggle<CR>")
    map("n", "<Leader><F4>", ":MinimapRescan<CR> :MinimapRefresh<CR>")

    map("n", "<F2>", ":NvimTreeToggle<CR>")
    map("n", "<Leader>`", ":ToggleTerm<CR>")

    map("n", "<Home>", ":lua ExtendedHome()<CR>")
    map("i", "<Home>", "<C-O>:lua ExtendedHome()<CR>")

    map("n", "<Leader>s", ":lua Scratch()<CR>")

    map("n", "<Leader>tt", ":Trouble<CR>")
    map("n", "<Leader>td", ":Trouble document_diagnostics<CR>")
    map("n", "<Leader>tw", ":Trouble workspace_diagnostics<CR>")
end

return set()
