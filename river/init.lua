-- Handlers
local notifier = function(options)
    local notify = "dunstify"

    if type(options.app) ~= "nil" then
        notify = notify .. string.format([[ -a "%s"]], options.app)
    end

    if type(options.title) == "nil" or type(options.message) == "nil" then
        error("I need a title and a message...")
    else
        notify = notify .. string.format([[ "%s" "%s"]], options.title, options.message)
    end

    return notify
end

-- Global map function
local map = function(modifier, key, command, opts)
    if type(opts) == "nil" then
        opts = {
            mode = "normal",
            style = "map"
        }
    end

    if type(opts.mode) == "nil" then
        opts.mode = "normal"
    end

    if type(opts.style) == "nil" then
        opts.style = "map"
    end

    local cmd1 = string.format([[riverctl %s]], opts["style"])

    if opts.kbrepeat then
        cmd1 = cmd1 .. " -repeat"
    elseif opts.release then
        cmd1 = cmd1 .. " -release"
    end

    local cmd = string.format([[%s %s %s %s %s]], cmd1, opts["mode"], modifier, key, command)
    os.execute(cmd)
end

local cmap = function(modifier, key, command, opts)
    map(modifier, key, string.format([[spawn '%s']], command), opts)
end


-- Main Config

-- Screenshot utilities
cmap("Shift", "Print", string.format([[grim -g "$(slurp)" -t png && %s]],
    notifier({
        app = "Grim",
        title = "New Screenshot",
        message = "Screenshot saved to ~/Pictures"
    }))
)

cmap("None", "Print", string.format([[grim -t png && %s]],
    notifier({
        app = "Grim",
        title = "New Screenshot",
        message = "Screenshot saved to ~/Pictures"
    }))
)

cmap("Control", "Print", string.format([[grim -t png - | wl-copy -t image/png && %s]],
    notifier({
        app = "Grim",
        title = "New Screenshot",
        message = "Screenshot copied to clipboard"
    }))
)

cmap("Control+Shift", "Print", string.format([[grim -t png -g "$(slurp)" - | wl-copy -t image/png && %s]],
    notifier({
        app = "Grim",
        title = "New Screenshot",
        message = "Screenshot copied to clipboard"
    }))
)

-- Handlers
-- for dev, tab in pairs(device) do
--     if type(tab) == "table" then
--         for prop, value in pairs(tab) do
--             os.execute(string.format([[riverctl input '%s' '%s' '%s']], dev, prop, value))
--         end
--     end
-- end

-- Configure Gnome GTK settings
-- for class, properties in pairs(gsettings) do
--     for property, value in pairs(properties) do
--         os.execute(string.format([[gsettings set %s %s %s]], class, property, value))
--     end
-- end

-- for prop, value in pairs(border) do
--     os.execute(string.format([[riverctl border-%s %s]], prop, value))
-- end

-- os.execute(string.format("systemctl --user import-environment %s", table.concat(systemd_env, ' ')))
-- os.execute(string.format("dbus-update-activation-environment --systemd %s", table.concat(dbus_env, ' ')))
-- os.execute(string.format("dbus-update-activation-environment %s", table.concat(dbus_env, ' ')))
