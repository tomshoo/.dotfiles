local cmp = require 'cmp'

return {
    sources = cmp.config.sources {
        { name = 'snippy' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
    }
}
