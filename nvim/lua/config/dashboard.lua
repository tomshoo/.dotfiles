local M = {}

local asciiart = {
    [[|                                             ,--,  ,.-.       |]],
    [[|               ,                   \,       '-,-`,'-.' | ._   |]],
    [[|              /|           \    ,   |\         }  )/  / `-,', |]],
    [[|              [ ,          |\  /|   | |        /  \|  |/`  ,` |]],
    [[|              | |       ,.`  `,` `, | |  _,...(   (      .',  |]],
    [[|              \  \  __ ,-` `  ,  , `/ |,'      Y     (   /_L\ |]],
    [[|               \  \_\,``,   ` , ,  /  |         )         _,/ |]],
    [[|                \  '  `  ,_ _`_,-,<._.<        /         /    |]],
    [[|                 ', `>.,`  `  `   ,., |_      |         /     |]],
    [[|                   \/`  `,   `   ,`  | /__,.-`    _,   `\     |]],
    [[|               -,-..\  _  \  `  /  ,  / `._) _,-\`       \    |]],
    [[|                \_,,.) /\    ` /  / ) (-,, ``    ,        |   |]],
    [[|               ,` )  | \_\       '-`  |  `(               \   |]],
    [[|              /  /```(   , --, ,' \   |`<`    ,            |  |]],
    [[|             /  /_,--`\   <\  V /> ,` )<_/)  | \      _____)  |]],
    [[|       ,-, ,`   `   (_,\ \    |   /) / __/  /   `----`        |]],
    [[|      (-, \           ) \ ('_.-._)/ /,`    /                  |]],
    [[|      | /  `          `/ \\ V   V, /`     /                   |]],
    [[|   ,--\(        ,     <_/`\\     ||      /                    |]],
    [[|  (   ,``-     \/|         \-A.A-`|     /                     |]],
    [[|  ,>,_ )_,..(    )\          -,,_-`  _--`                     |]],
    [[| (_ \|`   _,/_  /  \_            ,--`                         |]],
    [[|  \( `   <.,../`     `-.._   _,-`                             |]],
}

function M.setup()
    local ok, alpha = pcall(require, "alpha")

    if not ok then
        return false
    end
    local dashboard = require('alpha.themes.dashboard')
    dashboard.section.header.val = asciiart
    dashboard.section.buttons.val = {
        dashboard.button("SPC f f", "  Find file", ":Telescope find_files hidden=true no_ignore=true<CR>"),
        dashboard.button("SPC f h", "  Recently opened files", "<cmd>Telescope frecency<CR>"),
        dashboard.button("SPC f r", "  Frecency/MRU", "<cmd>Telescope frecency<CR>"),
        dashboard.button("SPC f g", "  Find word", "<cmd>Telescope live_grep<cr>"),
        dashboard.button("SPC f p", "  Open recent Projects", "<cmd>Telescope projects<CR>"),
        dashboard.button("SPC s l", "  Open last session", "<cmd>SessionManager load_last_session<CR>"),
        dashboard.button("q", "Quit", "<cmd>quit<CR>"),
    }
    alpha.setup(dashboard.config)
    return true
end

return M
