local M = {}

local cfg = {
    branch_separator = "_",
    autosave = true,
    autoload = false,
    allowed_dirs = {
        "~/.dotfiles/",
        "~/Projects/",
    }
}

function M.setup()
    local ok, session = pcall(require, 'persisted')
    if not ok then
        return false
    end

    session.setup(cfg)
    return true
end

return M
