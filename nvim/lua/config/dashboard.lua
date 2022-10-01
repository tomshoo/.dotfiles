local M = {}

local header = {
    string.format([=[                         ==[ Neovim v%s.%s.%s ]==                         ]=], version["major"],
        version["minor"], version["patch"]),
    [[                                                                         ]],
    [[          _        _______  _______          _________ _______           ]],
    [[         ( (    /|(  ____ \(  ___  )|\     /|\__   __/(       )          ]],
    [[         |  \  ( || (    \/| (   ) || )   ( |   ) (   | () () |          ]],
    [[         |   \ | || (__    | |   | || |   | |   | |   | || || |          ]],
    [[         | (\ \) ||  __)   | |   | |( (   ) )   | |   | |(_)| |          ]],
    [[         | | \   || (      | |   | | \ \_/ /    | |   | |   | |          ]],
    [[         | )  \  || (____/\| (___) |  \   /  ___) (___| )   ( |          ]],
    [[         |/    )_)(_______/(_______)   \_/   \_______/|/     \|          ]],
    [[         ______________________________________________________          ]],
    [[                                                                         ]],
    [=[   ==[ Do you want brainfuck? Cuz, that's how you get a brainfuck ]==   ]=]
}

local footer = {
    [[                                                                                               ]],
    [=[ ==[ Life fucks you in truely the most beautiful way possible, when you "most" expect it ]== ]=],
    [[                                                                                               ]]
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
        dashboard.button("SPC f r", "  Frecency/MRU", "<cmd>Telescope frecency<CR>"),
        dashboard.button("SPC f g", "  Find word", "<cmd>Telescope live_grep<cr>"),
        dashboard.button("SPC f p", "  Open recent Projects", "<cmd>Telescope projects<CR>"),
        dashboard.button("SPC f c", "  Open neovim config", "<cmd>edit " .. vim.fn.stdpath('config') .. "<CR>"),
        dashboard.button("SPC s l", "  Open last session", "<cmd>SessionLoadLast<CR>"),
        dashboard.button("q", "  Quit", "<cmd>quitall!<CR>"),
    }
    dashboard.section.footer.val = footer
    alpha.setup(dashboard.config)
    return true
end

return M
