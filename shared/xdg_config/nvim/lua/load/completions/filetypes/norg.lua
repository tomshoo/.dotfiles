local cmp = require 'cmp'

return {
    source = cmp.config.sources {
        { name = '[Neorg]' },
        { name = 'buffer' }
    }
}
