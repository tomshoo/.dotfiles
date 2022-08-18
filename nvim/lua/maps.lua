vim.cmd [[
    noremap <Space> <Nop>
    let mapleader = " "
]]

_G.map = function(mode, key, action, opts)
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

    map("n", "<Leader>wn", "<cmd>w <bar> bn<CR>")
    map("n", "<Leader>wp", "<cmd>w <bar> bp<CR>")

    map("n", "<Leader>bn", "<cmd>bn<CR>")
    map("n", "<Leader>bp", "<cmd>bp<CR>")
    map("n", "<Leader>bq", "<cmd>bd|quit!<CR>")
    map("n", "<Leader>bQ", "<cmd>bw<CR>")

    map("n", "<Leader>u", "<cmd>TSToggle highlight<CR>")
    map("n", "<F3>", "<cmd>TagbarToggle<CR>")
    map("n", "<F4>", "<cmd>MinimapToggle<CR>")
    map("n", "<Leader><F4>", "<cmd>MinimapRescan<CR> :MinimapRefresh<CR>")

    map("n", "<F2>", "<cmd>NvimTreeToggle<CR>")
    map("n", "<Leader>`", "<cmd>ToggleTerm<CR>")

    map("n", "<Home>", "<cmd>lua ExtendedHome()<CR>")
    map("i", "<Home>", "<C-O><cmd>lua ExtendedHome()<CR>")

    map("n", "<Leader>s", "<cmd>lua Scratch()<CR>")

    map("n", "tw", "<cmd>Twilight<CR>")

    map("n", "<Leader>tt", "<cmd>Trouble<CR>")
    map("n", "<Leader>td", "<cmd>Trouble document_diagnostics<CR>")
    map("n", "<Leader>tw", "<cmd>Trouble workspace_diagnostics<CR>")

    map("n", "<Leader>ff", "<cmd>Telescope find_files<CR>")
    map("n", "<Leader>fg", "<cmd>Telescope live_grep<CR>")
    map("n", "<Leader>fr", "<cmd>Telescope frecency<CR>")
    map("n", "<Leader>fp", "<cmd>Telescope projects<CR>")

    map("n", "<C-s>", "<cmd>SessionSave<CR>", { silent = false })

    map("n", "<Tab>", "<cmd>foldopen<CR>")
    map("n", "<S-Tab>", "<cmd>foldclose<CR>")

    map("n", "<Leader>q", "<cmd>quit!<CR>")
    map("n", "<Leader>Q", "<cmd>quitall!<CR>")
end

return set()
