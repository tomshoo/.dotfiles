local clangd_extension = require('clangd_extensions')

local server_config    = {}
local extensions       = {
    autoSetHints = true,
    inlay_hints = {
        right_align = true,
    }
}

clangd_extension.setup {
    server     = server_config,
    extensions = extensions,
}
