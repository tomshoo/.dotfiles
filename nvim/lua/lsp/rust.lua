local rt = require 'rust-tools'

local server_settings = {
    ['rust-analyzer'] = {
        checkOnSave = {
            command    = 'clippy',
            allTargets = false,
        },
    }
}

rt.setup {
    autoSetHints = true,
    server       = { settings = server_settings },
    tools        = { right_align = true }
}

vim.api.nvim_create_autocmd({ "LspAttach" }, {
    group = vim.api.nvim_create_augroup('rust-analyzer', { clear = true }),
    pattern = { '*.rs' },
    callback = function(args)
        local bufnr = args.buf
        map('n', '<leader>e', rt.expand_macro.expand_macro, { desc = "Expand macros", buffer = bufnr })
    end
})
