local M = {}

local cfg = {
    detection_methods = { 'pattern' },
    patterns = {
        ">Projects",
        "!=nvim",
        ".git",
        "Makefile",
        "Cargo.toml",
        "*setup*"
    },
    exclude_dirs = {
        "~/.local/share/nvim/*",
        "~/.cargo/*"
    },
    scope_chdir = 'tab'
}

function M.setup()
    local ok, projects = pcall(require, 'project_nvim')
    if not ok then
        return false
    end
    projects.setup(cfg)
    return true
end

return M
