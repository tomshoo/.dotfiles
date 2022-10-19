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

local function set()
    map("n", "<esc>", "<cmd>noh<CR><cmd>echo ''<CR>", { remap = true })
    map("n", "<S-CR>", "o<esc>k", { remap = true })
    map("n", "<C-CR>", "O<esc>j", { remap = true })
    map("n", "x", [["_x]])

    map("n", "<Leader>sv", "<C-w>v<cmd>enew<CR>", { desc = "Open a new vertical split" })
    map("n", "<Leader>sh", "<C-w>h<cmd>enew<CR>", { desc = "Open a new horizontal split" })

    map("n", "<Leader>wn", "<cmd>w <bar> bn<CR>")
    map("n", "<Leader>wp", "<cmd>w <bar> bp<CR>")

    map("n", "<Leader>bn", "<cmd>bn<CR>", { desc = "Go to next buffer" })
    map("n", "<Leader>bp", "<cmd>bp<CR>", { desc = "Go to previous buffer" })
    map("n", "<Leader>bq", "<cmd>bd|quit!<CR>", { desc = "Quit current buffer" })
    map("n", "<Leader>bQ", "<cmd>bw<CR>", { desc = "Completly wipe current buffer" })

    map("n", "<Leader>u", "<cmd>TSToggle highlight<CR>")
    map("n", "<F3>", "<cmd>SymbolsOutline<CR>")

    map("n", "<F2>", "<cmd>NvimTreeToggle<CR>")
    map("n", "<Leader>`", "<cmd>ToggleTerm<CR>")

    map("n", "<Home>", extended_home)
    map("i", "<Home>", "<C-o><Home>", { remap = true })

    map("n", "<Leader>s", scratchpad, { desc = "Launch a scratchpad" })

    map("n", "tw", "<cmd>Twilight<CR>")

    map("n", "<Leader>tt", "<cmd>Trouble<CR>")
    map("n", "<Leader>td", "<cmd>Trouble document_diagnostics<CR>")
    map("n", "<Leader>tw", "<cmd>Trouble workspace_diagnostics<CR>")

    map("n", "<Leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files in the current directory" })
    map("n", "<Leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Find files by content" })
    map("n", "<Leader>fr", "<cmd>Telescope frecency theme=ivy previewer=false<CR>",
        { desc = "List frecently viewed files" })
    map("n", "<Leader>fp", "<cmd>Telescope projects<CR>", { desc = "List all projects" })
    map("n", "<Leader>bl", "<cmd>Telescope buffers<CR>", { desc = "List all projects" })

    map("n", "<C-s>", "<cmd>SessionSave<CR>", { desc = "Save the current session" })

    map("n", "<Tab>", "<cmd>foldopen<CR>")
    map("n", "<S-Tab>", "<cmd>foldclose<CR>")

    map("n", "<Leader>q", "<cmd>quit!<CR>", { desc = "Quit the current window without saving" })
    map("n", "<Leader>Q", "<cmd>quitall!<CR>", { desc = "Quit all windows without saving" })
end

return set()
