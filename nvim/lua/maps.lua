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
    map("n", "<esc>", "<cmd>noh<CR><cmd>echon ''<CR>", { remap = true })
    map("n", "<S-CR>", "o<esc>k", { remap = true })
    map("n", "<C-CR>", "O<esc>j", { remap = true })
    map("n", "x", [["_x]])
    map("v", "x", [["_x]])

    map("n", "<leader>sv", "<C-w>v<cmd>enew<CR>", { desc = "Open a new vertical split" })
    map("n", "<leader>sh", "<C-w>h<cmd>enew<CR>", { desc = "Open a new horizontal split" })

    map("n", "<leader>bn", vim.cmd.BufferNext, { desc = "Go to next buffer" })
    map("n", "<leader>bp", vim.cmd.BufferPrevious, { desc = "Go to previous buffer" })
    map("n", "<leader>bq", "<cmd>bd|quit!<CR>", { desc = "Quit current buffer" })
    map("n", "<leader>bQ", vim.cmd.BufferWipeout, { desc = "Completly wipe current buffer" })

    map("n", "<leader>u", "<cmd>TSToggle highlight<CR>", { desc = "Toggle treesitter highlighting" })
    map("n", "<F3>", "<cmd>SymbolsOutline<CR>", { desc = "Show treesitter symbols" })

    map("n", "<leader>E", vim.cmd.NvimTreeToggle)
    map("n", "<leader>`", vim.cmd.ToggleTerm)

    map("n", "<Home>", extended_home)
    map("v", "<Home>", extended_home)
    map("i", "<Home>", "<C-o><Home>", { remap = true })

    map("n", "<leader>s", scratchpad, { desc = "Launch a scratchpad" })

    map("n", "tw", vim.cmd.Twilight, { desc = "Toggle code shading" })

    map("n", "<leader>tt", "<cmd>Trouble<CR>")
    map("n", "<leader>td", "<cmd>Trouble document_diagnostics<CR>")
    map("n", "<leader>tw", "<cmd>Trouble workspace_diagnostics<CR>")

    map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files in the current directory" })
    map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Find files by content" })
    map("n", "<leader>fr", "<cmd>Telescope frecency theme=ivy previewer=false<CR>",
        { desc = "List frecently viewed files" })
    map("n", "<leader>fp", "<cmd>Telescope projects<CR>", { desc = "List all projects" })
    map("n", "<leader>bl", "<cmd>Telescope buffers<CR>", { desc = "List all buffers" })

    map("n", "<C-s>", "<cmd>SessionSave<CR>", { desc = "Save the current session" })

    map("n", "<Tab>", vim.cmd.foldopen)
    map("n", "<S-Tab>", vim.cmd.foldclose)

    map("n", "<leader>q", "<cmd>quit!<CR>", { desc = "Quit the current window without saving" })
    map("n", "<leader>Q", "<cmd>quitall!<CR>", { desc = "Quit all windows without saving" })
end

return set()
