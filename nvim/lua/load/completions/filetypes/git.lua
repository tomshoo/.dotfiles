local cmp = require 'cmp'

return {
    sources = cmp.config.sources {
        { name = 'git' },
        { name = 'buffer' },
    }
}
