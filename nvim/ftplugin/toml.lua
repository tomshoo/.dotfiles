if vim.fn.expand('%:t') == "Cargo.toml" then
    pcall(function()
        vim.g.loaded_crates = true
        if vim.g.loaded_crates then require('crates').setup() end
    end)
end
