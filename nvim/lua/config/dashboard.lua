local M = {}

local header = {
    [[ _        _______  _______          _________ _______ ]],
    [[( (    /|(  ____ \(  ___  )|\     /|\__   __/(       )]],
    [[|  \  ( || (    \/| (   ) || )   ( |   ) (   | () () |]],
    [[|   \ | || (__    | |   | || |   | |   | |   | || || |]],
    [[| (\ \) ||  __)   | |   | |( (   ) )   | |   | |(_)| |]],
    [[| | \   || (      | |   | | \ \_/ /    | |   | |   | |]],
    [[| )  \  || (____/\| (___) |  \   /  ___) (___| )   ( |]],
    [[|/    )_)(_______/(_______)   \_/   \_______/|/     \|]],
}

local footer = {
    string.format([=[==[ NVIM v%s.%s.%s ]==]=], version["major"], version["minor"], version["patch"]),
}

function M.setup()
    local ok, alpha = pcall(require, "alpha")

    if not ok then
        return false
    end
    local dashboard = require('alpha.themes.dashboard')
    dashboard.section.header.val = header
    dashboard.section.buttons.val = {
        dashboard.button("SPC f n", "  Open a new file", "<cmd>tabnew<CR>"),
        dashboard.button("SPC f f", "  Find file", "<cmd>Telescope find_files hidden=true no_ignore=true<CR>"),
        dashboard.button("SPC f r", "  Frecency/MRU", "<cmd>Telescope frecency theme=ivy previewer=false<CR>"),
        dashboard.button("SPC f g", "  Find word", "<cmd>Telescope live_grep<cr>"),
        dashboard.button("SPC f p", "  Open recent Projects", "<cmd>Telescope projects theme=ivy<CR>"),
        dashboard.button("SPC f c", "  Open neovim config", "<cmd>edit " .. vim.fn.stdpath('config') .. "<CR>"),
        dashboard.button("SPC s l", "  Open last session", "<cmd>SessionLoadLast<CR>"),
        dashboard.button("q", "  Quit", "<cmd>quitall!<CR>"),
    }
    dashboard.section.footer.val = footer
    alpha.setup(dashboard.config)
    return true
end

return M
