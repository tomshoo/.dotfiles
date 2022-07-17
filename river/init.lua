-- Required for luajit v5.1 bitwise operations
local bits = require("bit")

-- Configure variables for init
local scripts    = os.getenv("HOME") .. "/.config/river/scripts"
local main_ratio = 0.55
local main_low   = 0.25
local main_high  = 0.75

-- Set default tiling manager
local tiler = "rivertile"

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

local systemctl_import = {
    "WAYLAND_DISPLAY",
    "DISPLAY",
    "XDG_CURRENT_DESKTOP",
    "MOZ_ENABLE_WAYLAND"
}

local floating_apps = {
    "thunar",
    "Rofi",
    "org.kde.dolphin"
}

-- GSettings configurations
local gsettings = {
    ["org.gnome.desktop.wm.preferences"] = {
        ["button-layout"] = [[' ']]
    },
    ["org.gnome.desktop.interface"] = {
        ["cursor-theme"] = "Vimix-Beryl-dark",
        ["icon-theme"]   = "Vimix-Beryl-dark",
        ["gtk-theme"]    = "vimix-dark-beryl",
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

-- Autostart applications
launch(scripts .. "/wallpaper.sh")
launch(scripts .. "/waybar.sh")
launch("foot --server")
launch("dbus-launch")

-- Key binding configurations
local keybinding = {
    command = {
        ["Super"] = {
            {
                key  = "Return",
                exec = "footclient",
            },
            {
                key  = "Space",
                exec = "wofi --show drun",
            },
            {
                key  = "B",
                exec = "killall waybar"
            },
            {
                key  = "E",
                exec = "thunar",
            }
        },
        ["Super+Shift"] = {
            {
                key  = "B",
                exec = scripts .. "/waybar.sh"
            }
        },
        ["Control+Alt"] = {
            {
                key  = "Delete",
                exec = scripts .. "/rofi-logout-menu",
            }
        },
        ["Alt"] = {
            {
                key  = "P",
                exec = scripts .. "/wallpaper.sh",
            }
        }
    },
    tiling = {
        ["Super"] = {
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
        ["Super+Alt"] = {
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
        ["Alt+Shift"] = {
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
        ["Super+Shift"] = {
            {
                key  = "bar",
                exec = "main-ratio 0.5"
            }
        }
    },
    river = {
        ["Super"] = {
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
                key  = "M",
                exec = "zoom"
            },
            {
                key  = "F",
                exec = "toggle-fullscreen"
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
        ["Super+Control"] = {
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
        ["Super+Shift"] = {
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
            {
                key  = "S",
                exec = "toggle-float"
            }
        },
        ["Alt"] = {
            {
                key  = "J",
                exec = "swap next"
            },
            {
                key  = "Semicolon",
                exec = "swap previous"
            }
        },
        ["Super+Alt"] = { {
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

-- Volume and brightness control
for _, rmode in pairs({ "normal", "locked" }) do
    cmap("None", "XF86AudioRaiseVolume", scripts .. "/volume -i 5", { mode = rmode, kbrepeat = true })
    cmap("None", "XF86AudioLowerVolume", scripts .. "/volume -d 5", { mode = rmode, kbrepeat = true })
    cmap("None", "XF86AudioMute", scripts .. "/volume -m 0", { mode = rmode, kbrepeat = true })
    cmap("None", "XF86MonBrightnessUp", scripts .. "/brightness -i 2.5", { mode = rmode, kbrepeat = true })
    cmap("None", "XF86MonBrightnessDown", scripts .. "/brightness -d 2.5", { mode = rmode, kbrepeat = true })
end

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

-- Set mappings for view tags
for i = 1, 9 do
    local tag_id = bits.lshift(1, i - 1)
    map("Super", string.format("%d", i), string.format("set-focused-tags %d", tag_id))
    map("Super+Shift", string.format("%d", i), string.format("set-view-tags %d", tag_id))
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

os.execute(string.format("systemctl --user import-environment %s", table.concat(systemctl_import, ' ')))
os.execute(string.format("dbus-update-activation-environment --systemd %s", table.concat(dbus_env, ' ')))
os.execute(string.format("riverctl default-layout %s", tiler))
