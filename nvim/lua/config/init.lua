local function commenter()
    local ok, comment = pcall(require, 'Comment')
    if ok then
        comment.setup()
    end
end

local function gitsigns()
    local ok, gsigns = pcall(require, 'gitsigns')
    if ok then
        gsigns.setup()
    end
end

local function keycmp()
    local ok, whichkey = pcall(require, 'which-key')
    if ok then
        whichkey.setup()
    end
end

local function projects()
    local ok, project_nvim = pcall(require, 'project_nvim')
    if ok then
        project_nvim.setup()
    end
end

local function terminal()
    local ok, term = pcall(require, 'toggleterm')
    if ok then
        term.setup()
    end
end

-- Load everything
require('config.treesitter').setup()
require('config.telescope').setup()
require('config.lsp').setup()
require('config.colorscheme').setup()
require('config.nvimtree').setup()
require('config.lualine').setup()
require('config.bufferline').setup()
require('config.dashboard').setup()
require('config.autopairs').setup()
require('config.indentguide').setup()
require('config.trouble').setup()

commenter()
gitsigns()
keycmp()
projects()
terminal()
