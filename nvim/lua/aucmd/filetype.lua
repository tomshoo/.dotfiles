local M = {}

local function crates_setup()
    local ok, crates = pcall(require, 'crates')
    if ok then
        crates.setup()
    end
end

function M.setup()
    local cgroup = vim.api.nvim_create_augroup("CrateGroup", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
        pattern = "Cargo.toml",
        callback = crates_setup,
        group = cgroup
    })

    local ygroup = vim.api.nvim_create_augroup("YuckFiles", { clear = true })
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufEnter" }, {
        pattern = "*.yuck",
        group = ygroup,
        command = "set ft=yuck"
    })
end

return M
