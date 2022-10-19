-- Configure variables for init
local scripts    = os.getenv("SCRIPTS")
local main_ratio = os.getenv("MAIN_RATIO")
local main_low   = 0.25
local main_high  = 0.75

-- Set default tiling manager
local tiler = os.getenv("TILER")

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

local launch = function(cmd)
    os.execute(string.format([[riverctl spawn '%s']], cmd))
end

local tmap = function(modifier, key, command, opts)
    map(modifier, key, string.format([[send-layout-cmd %s "%s"]], tiler, command), opts)
end

local cmap = function(modifier, key, command, opts)
    map(modifier, key, string.format([[spawn '%s']], command), opts)
end


-- Main Config

-- Update environment variables for dbus
local dbus_env = {
    "XDG_CURRENT_DESKTOP",
    "DISPLAY",
    "WAYLAND_DISPLAY",
    "SWAYSOCK",
    "MOZ_ENABLE_WAYLAND"
}

-- local systemd_env = {
--     "WAYLAND_DISPLAY",
--     "DISPLAY",
--     "XDG_CURRENT_DESKTOP",
--     "MOZ_ENABLE_WAYLAND"
-- }

local floating_apps = {
    "thunar",
    "pcmanfm",
    "Rofi",
    "org.kde.dolphin",
    "lxqt-policykit-agent",
    "io.github.seadve.Mousai"
}

-- GSettings configurations
local gsettings = {
    ["org.gnome.desktop.wm.preferences"] = {
        ["button-layout"] = [[' ']]
    },
    ["org.gnome.desktop.interface"] = {
        ["cursor-theme"] = "Breeze_Snow",
        ["icon-theme"]   = "Papirus-Dark",
        ["gtk-theme"]    = "Orchis-Dark-Compact",
    },
    ["org.gnome.desktop.default-applications.terminal"] = {
        exec = "footclient"
    }
}

-- Input hardware configurations
local device = {
    ["1739:32382:CUST0001:00_06CB:7E7E_Touchpad"] = {
        ["tap"] = "enabled",
        ["natural-scroll"] = "enabled"
    }
}

local border = {
    ["color-focused"] = "0x48b0fa",
    ["color-unfocused"] = "0x000000",
    width = 1
}

-- Autostart applications
launch(scripts .. "/wallpaper.sh")
launch(scripts .. "/waybar.sh")
launch("lxqt-policykit-agent")
launch("foot --server")
launch("dbus-launch")

-- Key binding configurations
local keybinding = {
    command = {
        ["Control+Mod1"] = {},
        ["Mod1"] = {
            {
                key  = "P",
                exec = scripts .. "/wallpaper.sh",
            }
        }
    },
    tiling = {
        ["Mod4"] = {
            {
                key  = "Equal",
                exec = string.format([[main-ratio %f]], main_ratio)
            },
            {
                key  = "bracketleft",
                exec = string.format([[main-ratio %f]], main_low)
            },
            {
                key  = "bracketright",
                exec = string.format([[main-ratio %f]], main_high)
            },
            {
                key  = "comma",
                exec = "main-count +1"
            },
            {
                key  = "period",
                exec = "main-count -1"
            }
        },
        ["Mod4+Mod1"] = {
            {
                key  = "J",
                exec = "main-location left"
            },
            {
                key  = "K",
                exec = "main-location bottom"
            },
            {
                key  = "L",
                exec = "main-location top"
            },
            {
                key  = "Semicolon",
                exec = "main-location right"
            }
        },
        ["Mod1+Shift"] = {
            {
                key      = "J",
                exec     = "main-ratio -0.01",
                kbrepeat = true
            },
            {
                key      = "Semicolon",
                exec     = "main-ratio +0.01",
                kbrepeat = true
            }
        },
        ["Mod4+Shift"] = {
            {
                key  = "bar",
                exec = "main-ratio 0.5"
            },
            {
                key = "M",
                exec = "main-location monocle"
            }
        }
    },
    river = {
        ["Mod4"] = {
            {
                key  = "W",
                exec = "close"
            },
            {
                key  = "J",
                exec = "focus-view next"
            },
            {
                key  = "Semicolon",
                exec = "focus-view previous"
            },
            {
                key  = "K",
                exec = "attach-mode bottom"
            },
            {
                key = "L",
                exec = "attach-mode top"
            },
            {
                key  = "M",
                exec = "zoom"
            },
            {
                key  = "F",
                exec = "toggle-fullscreen"
            },
            {
                key  = "T",
                exec = "toggle-float"
            },
            {
                key     = "BTN_RIGHT",
                pointer = true,
                exec    = "resize-view"
            },
            {
                key     = "BTN_LEFT",
                pointer = true,
                exec    = "move-view"
            }
        },
        ["Mod4+Control"] = {
            {
                key      = "J",
                exec     = "move left 100",
                kbrepeat = true
            },
            {
                key      = "K",
                exec     = "move down 100",
                kbrepeat = true
            },
            {
                key      = "L",
                exec     = "move up 100",
                kbrepeat = true
            },
            {
                key      = "Semicolon",
                exec     = "move right 100",
                kbrepeat = true
            }
        },
        ["Mod4+Shift"] = {
            {
                key      = "J",
                exec     = "resize horizontal 100",
                kbrepeat = true
            },
            {
                key      = "K",
                exec     = "resize vertical -100",
                kbrepeat = true
            },
            {
                key      = "L",
                exec     = "resize vertical 100",
                kbrepeat = true
            },
            {
                key      = "Semicolon",
                exec     = "resize horizontal -100",
                kbrepeat = true
            },
        },
        ["Mod1"] = {
            {
                key  = "J",
                exec = "swap next"
            },
            {
                key  = "Semicolon",
                exec = "swap previous"
            }
        },
        ["Mod4+Mod1"] = { {
            key  = "Q",
            exec = "exit"
        } }
    }
}

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
for dev, tab in pairs(device) do
    if type(tab) == "table" then
        for prop, value in pairs(tab) do
            os.execute(string.format([[riverctl input '%s' '%s' '%s']], dev, prop, value))
        end
    end
end

for bindstyle, modifiers in pairs(keybinding) do
    for modifier, bindings in pairs(modifiers) do
        for _, prop in pairs(bindings) do
            local mapstyle = "map"

            if prop.pointer == true then
                mapstyle = "map-pointer"
            end

            local opts = {
                style = mapstyle
            }

            if prop.kbrepeat then
                opts.kbrepeat = true
            elseif prop.release then
                opts["release"] = true
            end

            if bindstyle == "command" then
                cmap(modifier, prop.key, prop.exec, opts)
            elseif bindstyle == "tiling" then
                tmap(modifier, prop.key, prop.exec, opts)
            elseif bindstyle == "river" then
                map(modifier, prop.key, prop.exec, opts)
            end
        end
    end
end

-- Configure Gnome GTK settings
for class, properties in pairs(gsettings) do
    for property, value in pairs(properties) do
        os.execute(string.format([[gsettings set %s %s %s]], class, property, value))
    end
end

for _, app in ipairs(floating_apps) do
    os.execute(string.format([[riverctl float-filter-add app-id "%s"]], app))
end

for prop, value in pairs(border) do
    os.execute(string.format([[riverctl border-%s %s]], prop, value))
end

-- os.execute(string.format("systemctl --user import-environment %s", table.concat(systemd_env, ' ')))
-- os.execute(string.format("dbus-update-activation-environment --systemd %s", table.concat(dbus_env, ' ')))
os.execute(string.format("dbus-update-activation-environment %s", table.concat(dbus_env, ' ')))
