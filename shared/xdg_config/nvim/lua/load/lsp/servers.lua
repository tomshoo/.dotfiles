vim.g.zig_fmt_parse_errors = 0


local servers         = {}

servers.lua_ls        = {
    settings = {
        Lua = { telimitery = { enable = false } },
    }
}

servers.clangd        = {
    on_attach = function()
        local clangd_ext = require('clangd_extensions.inlay_hints')
        clangd_ext.setup_autocmd()
        clangd_ext.set_inlay_hints()
    end
}

servers.tsserver      = {}
servers.bashls        = { filetypes = { "sh", "bash" } }
servers.nil_ls        = {}
servers.perlnavigator = {}
servers.gopls         = {}

servers.zls           = {
    settings = {
        enable_autofix = false,
        warn_style     = true,
    }
}


servers.jedi_language_server = {}

-- servers.pyright       = {
--     settings = {
--         python = {
--             analysis = {
--                 autoSearchPaths = true,
--                 diagnosticMode = "workspace",
--                 useLibraryCodeForTypes = true,
--             }
--         }
--     }
-- }

return servers
