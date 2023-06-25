local wilder = require 'wilder'

wilder.set_option('renderer', wilder.renderer_mux({
    [':'] = wilder.popupmenu_renderer({
        highlighter     = wilder.basic_highlighter(),
        left            = { ' ', wilder.popupmenu_devicons() },
        min_height      = 0,
        max_height      = '30%',
        prompt_position = 'top',
        reverse         = 1,
    })
}))

wilder.setup {
    modes = { ':' },
}
