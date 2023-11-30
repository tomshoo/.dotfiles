local function aerial_on_attach(bufnr)
    mapkey('n', ']]', vim.cmd.AerialNext, { buffer = bufnr })
    mapkey('n', '[[', vim.cmd.AerialPrev, { buffer = bufnr })
end

local function setup()
    local aerial = require 'aerial'
    aerial.setup { on_attach = aerial_on_attach }
end

return {
    'stevearc/aerial.nvim',
    config = setup,
}
