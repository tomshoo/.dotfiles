M = {}

function M.setup()
    local titlegroup = vim.api.nvim_create_augroup("UpdateTitle", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
        pattern = "*",
        group = titlegroup,
        command = [[ set titlestring=%t%(\ %M%)%(\ \(%{expand(\"%:~:h\")}\)%)%a\ -\ NVIM ]]
    })
end

return M
