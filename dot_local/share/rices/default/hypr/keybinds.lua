-- ##! Shell

hl.bind("XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl s 5%+"),
    { locked = true, repeating = true }
)

hl.bind("XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl s 5%-"),
    { locked = true, repeating = true }
)

hl.bind("XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ -l 1.5"),
    { locked = true, repeating = true }
)

hl.bind("XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),
    { locked = true, repeating = true }
)

hl.bind("XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ toggle"),
    { locked = true }
)

hl.bind("SUPER + SHIFT + M",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ toggle"),
    { locked = true, description = "Toggle mute" }
)

hl.bind("ALT + XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle"),
    { locked = true }
)

hl.bind("XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle"),
    { locked = true }
)

hl.bind("SUPER + ALT + M",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle"),
    { locked = true, description = "Toggle mic" }
)


-- Bar

hl.bind("SUPER + J",
    hl.dsp.exec_cmd("pkill -SIGUSR1 waybar")
)

hl.bind("SUPER + SHIFT + J",
    hl.dsp.exec_cmd("pkill -SIGUSR2 waybar")
)


-- Notifications

hl.bind("SUPER + N",
    hl.dsp.exec_cmd("swaync-client -t")
)


-- ##! Utilities

hl.bind("SUPER + V",
    hl.dsp.exec_cmd("pkill rofi || cliphist list | rofi -dmenu | cliphist decode | wl-copy"),
    { description = "Copy clipboard history entry" }
)

hl.bind("Print",
    hl.dsp.exec_cmd("grim - | wl-copy"),
    { locked = true }
)

hl.bind("CTRL + Print",
    hl.dsp.exec_cmd([[mkdir -p $(xdg-user-dir PICTURES)/Screenshots && grim $(xdg-user-dir PICTURES)/Screenshots/Screenshot_"$(date '+%Y-%m-%d_%H.%M.%S')".png]]),
    { locked = true, non_consuming = true }
)

hl.bind("CTRL + Print",
    hl.dsp.exec_cmd("grim - | wl-copy"),
    { locked = true, non_consuming = true }
)

hl.bind("SUPER + SHIFT + S",
    hl.dsp.exec_cmd([[mkdir -p $(xdg-user-dir PICTURES)/Screenshots && FILE=$(xdg-user-dir PICTURES)/Screenshots/Screenshot_"$(date '+%Y-%m-%d_%H.%M.%S')".png && grim -g "$(slurp)" $FILE && cat $FILE | wl-copy]]),
    { non_consuming = true }
)

hl.bind("SUPER + F1",
    hl.dsp.exec_cmd("~/.local/share/rices/default/hypr/scripts/gamemode.sh")
)


-- Emoji Picker

hl.bind("SUPER + period",
    hl.dsp.exec_cmd([[pkill rofi || BEMOJI_PICKER_CMD="rofi -dmenu" bemoji -t -c -n]])
)



-- ##! Window

-- Focusing

hl.bind("SUPER + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true }
)

hl.bind("SUPER + mouse:274",
    hl.dsp.window.drag(),
    { mouse = true }
)

hl.bind("SUPER + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true }
)


-- Focus in direction

hl.bind("SUPER + Left",
    hl.dsp.focus({ direction = "left" })
)

hl.bind("SUPER + Right",
    hl.dsp.focus({ direction = "right" })
)

hl.bind("SUPER + Up",
    hl.dsp.focus({ direction = "up" })
)

hl.bind("SUPER + Down",
    hl.dsp.focus({ direction = "down" })
)

hl.bind("SUPER + BracketLeft",
    hl.dsp.focus({ direction = "left" })
)

hl.bind("SUPER + BracketRight",
    hl.dsp.focus({ direction = "right" })
)



-- Move in direction

hl.bind("SUPER + SHIFT + Left",
    hl.dsp.window.move({ direction = "left" })
)

hl.bind("SUPER + SHIFT + Right",
    hl.dsp.window.move({ direction = "right" })
)

hl.bind("SUPER + SHIFT + Up",
    hl.dsp.window.move({ direction = "up" })
)

hl.bind("SUPER + SHIFT + Down",
    hl.dsp.window.move({ direction = "down" })
)


-- Close

hl.bind("ALT + F4",
    hl.dsp.window.close()
)

hl.bind("SUPER + Q",
    hl.dsp.window.close()
)

hl.bind("SUPER + SHIFT + ALT + Q",
    hl.dsp.exec_cmd("hyprctl kill")
)


-- Window split ratio

hl.bind("SUPER + Semicolon",
    hl.dsp.layout("splitratio -0.1"),
    { repeating = true }
)

hl.bind("SUPER + Apostrophe",
    hl.dsp.layout("splitratio +0.1"),
    { repeating = true }
)


-- Positioning mode

hl.bind("SUPER + ALT + Space",
    hl.dsp.window.float({ action = "toggle" })
)

hl.bind("SUPER + D",
    hl.dsp.window.fullscreen({ mode = 1 })
)

hl.bind("SUPER + F",
    hl.dsp.window.fullscreen({ mode = 0 })
)

hl.bind("SUPER + ALT + F",
    hl.dsp.exec_cmd("hyprctl dispatch fullscreenstate 0 3")
)

hl.bind("SUPER + P",
    hl.dsp.window.pin()
)

-- Send to workspace left/right (scroll)

hl.bind("SUPER + SHIFT + mouse_down",
    hl.dsp.window.move({ workspace = "r+1" })
)

hl.bind("SUPER + SHIFT + mouse_up",
    hl.dsp.window.move({ workspace = "r-1" })
)

hl.bind("SUPER + ALT + mouse_down",
    hl.dsp.window.move({ workspace = "+1" })
)

hl.bind("SUPER + ALT + mouse_up",
    hl.dsp.window.move({ workspace = "-1" })
)


-- Send to workspace left/right (Page Up/Down)

hl.bind("SUPER + ALT + Page_Down",
    hl.dsp.window.move({ workspace = "+1" })
)

hl.bind("SUPER + ALT + Page_Up",
    hl.dsp.window.move({ workspace = "-1" })
)

hl.bind("SUPER + SHIFT + Page_Down",
    hl.dsp.window.move({ workspace = "r+1" })
)

hl.bind("SUPER + SHIFT + Page_Up",
    hl.dsp.window.move({ workspace = "r-1" })
)

hl.bind("CTRL + SUPER + SHIFT + Right",
    hl.dsp.window.move({ workspace = "r+1" })
)

hl.bind("CTRL + SUPER + SHIFT + Left",
    hl.dsp.window.move({ workspace = "r-1" })
)


-- Send to scratchpad

hl.bind("SUPER + ALT + S",
    hl.dsp.window.move({ workspace = "special" })
)

hl.bind("CTRL + SUPER + S",
    hl.dsp.workspace.toggle_special("special")
)



-- Focus left/right workspaces

hl.bind("CTRL + SUPER + Right",
    hl.dsp.focus({ workspace = "r+1" })
)

hl.bind("CTRL + SUPER + Left",
    hl.dsp.focus({ workspace = "r-1" })
)


-- Focus busy left/right

hl.bind("CTRL + SUPER + ALT + Right",
    hl.dsp.focus({ workspace = "m+1" })
)

hl.bind("CTRL + SUPER + ALT + Left",
    hl.dsp.focus({ workspace = "m-1" })
)


-- Focus left/right (Page Up/Down)

hl.bind("SUPER + Page_Down",
    hl.dsp.focus({ workspace = "+1" })
)

hl.bind("SUPER + Page_Up",
    hl.dsp.focus({ workspace = "-1" })
)

hl.bind("CTRL + SUPER + Page_Down",
    hl.dsp.focus({ workspace = "r+1" })
)

hl.bind("CTRL + SUPER + Page_Up",
    hl.dsp.focus({ workspace = "r-1" })
)


-- Focus left/right (scroll)

hl.bind("SUPER + mouse_up",
    hl.dsp.focus({ workspace = "-1" })
)

hl.bind("SUPER + mouse_down",
    hl.dsp.focus({ workspace = "+1" })
)

hl.bind("CTRL + SUPER + mouse_up",
    hl.dsp.focus({ workspace = "r+1" })
)

hl.bind("CTRL + SUPER + mouse_down",
    hl.dsp.focus({ workspace = "r-1" })
)



-- ##! Workspaces (number keys)

for i = 1, 10 do
    local key = i == 10 and "0" or tostring(i)

    hl.bind(
        "SUPER + " .. key,
        hl.dsp.focus({ workspace = i })
    )

    hl.bind(
        "SUPER + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = i })
    )
end



-- ##! Special

hl.bind("SUPER + S",
    hl.dsp.workspace.toggle_special("special")
)

hl.bind("SUPER + mouse:275",
    hl.dsp.workspace.toggle_special("special")
)

hl.bind("CTRL + SUPER + BracketLeft",
    hl.dsp.focus({ workspace = "-1" })
)

hl.bind("CTRL + SUPER + BracketRight",
    hl.dsp.focus({ workspace = "+1" })
)

hl.bind("CTRL + SUPER + Up",
    hl.dsp.focus({ workspace = "r-5" })
)

hl.bind("CTRL + SUPER + Down",
    hl.dsp.focus({ workspace = "r+5" })
)



-- ##! Session

hl.bind(
    "SUPER + L",
    hl.dsp.exec_cmd("loginctl lock-session"),
    { description = "Lock" }
)

hl.bind(
    "SUPER + SHIFT + L",
    hl.dsp.exec_cmd("systemctl suspend || loginctl suspend"),
    { locked = true, description = "Suspend system" }
)

hl.bind(
    "CTRL + SHIFT + ALT + SUPER + Delete",
    hl.dsp.exec_cmd("systemctl poweroff || loginctl poweroff"),
    { description = "Shutdown" }
)

-- ##! Screen
-- (No binds in original config)



-- ##! Media

hl.bind(
    "SUPER + SHIFT + N",
    hl.dsp.exec_cmd([[playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"`]]),
    { locked = true }
)

hl.bind(
    "XF86AudioNext",
    hl.dsp.exec_cmd([[playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"`]]),
    { locked = true }
)

hl.bind(
    "XF86AudioPrev",
    hl.dsp.exec_cmd("playerctl previous"),
    { locked = true }
)

hl.bind(
    "SUPER + SHIFT + ALT + mouse:275",
    hl.dsp.exec_cmd("playerctl previous")
)

hl.bind(
    "SUPER + SHIFT + ALT + mouse:276",
    hl.dsp.exec_cmd([[playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"`]])
)

hl.bind(
    "SUPER + SHIFT + B",
    hl.dsp.exec_cmd("playerctl previous"),
    { locked = true }
)

hl.bind(
    "SUPER + SHIFT + P",
    hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true }
)

hl.bind(
    "XF86AudioPlay",
    hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true }
)

hl.bind(
    "XF86AudioPause",
    hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true }
)



-- ##! Cursed stuff
-- Make window not amogus large

hl.bind(
    "CTRL + SUPER + Backslash",
    hl.dsp.exec_cmd("hyprctl dispatch resizeactive exact 640 480")
)
