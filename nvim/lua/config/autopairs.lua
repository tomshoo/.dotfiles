local M = {}


local cfg = {
    disable_filetype = {
        "scratch",
        "nofile"
    },
    check_ts = true,
}
function M.setup()
    local ok, autopairs = pcall(require, 'nvim-autopairs')
    if not ok then
        return false
    end

    autopairs.setup(cfg)
    return true
end

return M
