-- ######## Window rules
-- Floating dialogs
for _, title in ipairs({
    "^(Open File)(.*)$",
    "^(Select a File)(.*)$",
    "^(Open Folder)(.*)$",
    "^(Save As)(.*)$",
    "^(File Upload)(.*)$",
    "^(.*)(wants to save)$",
    "^(.*)(wants to open)$",
}) do
    hl.window_rule({
        match = {
            title = title,
        },
        float = true,
        center = true,
    })
end
hl.window_rule({
    match = {
        class = "kitty-btop",
    },
    float = true,
    size = { 900, 600 },
    center = true,
    dim_around = true,
})
-- Utility windows
for _, class in ipairs({
    "^pavucontrol$",
    "^nm-connection-editor$",
}) do
    hl.window_rule({
        match = {
            class = class,
        },
        float = true,
        center = true,
        size = {
            "monitor_w * 0.45",
            "monitor_h * 0.45",
        },
    })
end
hl.window_rule({
    match = {
        class = "^blueberry\\.py$",
    },
    float = true,
})
hl.window_rule({
    match = {
        class = "^guifetch$",
    },
    float = true,
})
-- Picture-in-Picture
hl.window_rule({
    match = {
        title = "^Picture-in-Picture$",
    },
    float = true,
    pin = true,
    keep_aspect_ratio = true,
    persistent_size = true,
    move = {
        "monitor_w * 0.70",
        "monitor_h * 0.05",
    },
})
-- Tiling
hl.window_rule({
    match = {
        class = "^dev\\.warp\\.Warp$",
    },
    tile = true,
})
-- Tearing (games)
hl.window_rule({
    match = {
        title = ".*\\.exe",
    },
    immediate = true,
})
hl.window_rule({
    match = {
        title = ".*minecraft.*",
    },
    immediate = true,
})
hl.window_rule({
    match = {
        class = "^(steam_app).*",
    },
    immediate = true,
})
-- Archetype Plini
hl.window_rule({
    match = {
        class = "^(archetype plini x\\.exe)$",
        title = "^(Archetype Plini X)$",
    },
    center = true,
    float = true,
    immediate = true
})
-- JetBrains IDE fix
hl.window_rule({
    match = {
        class = "^jetbrains-.*$",
        float = true,
        title = "^$|^\\s$|^win\\d+$",
    },
    no_initial_focus = true,
})
-- Discord
hl.window_rule({
    match = {
        class = "discord",
    },
    opacity = 0.92,
})
-- FFPlay / MPV
for _, class in ipairs({
    "^ffplay$",
    "^mpv$",
}) do
    hl.window_rule({
        match = {
            class = class,
        },
        immediate = true,
    })
end
-- ######## Workspace rules
hl.workspace_rule({
    workspace = "special:special",
    gaps_out = 30,
})
-- ######## Layer rules
-- Waybar
hl.layer_rule({
    match = {
        namespace = "waybar",
    },
    blur = true,
    ignore_alpha = 0.2,
})
-- Wlogout
hl.layer_rule({
    match = {
        namespace = "logout_dialog",
    },
    blur = true,
    ignore_alpha = 0.2,
})
-- SwayNC Control Center
hl.layer_rule({
    match = {
        namespace = "swaync-control-center",
    },
    animation = "slide right",
    blur = true,
    ignore_alpha = 0.2,
})
-- SwayNC Notifications
hl.layer_rule({
    match = {
        namespace = "swaync-notification-window",
    },
    animation = "slide right",
    blur = true,
    ignore_alpha = 0.2,
})
-- Rofi
hl.layer_rule({
    match = {
        namespace = "rofi",
    },
    blur = true,
    ignore_alpha = 0.2,
})
