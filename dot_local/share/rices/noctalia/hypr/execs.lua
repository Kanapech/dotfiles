-- Noctalia rice: the shell replaces waybar/swaync/rofi/hyprpaper.
-- Boot lock is Noctalia's, with a hyprlock fallback if the shell fails to start.
hl.on("hyprland.start", function()
    -- Core components (authentication, idle)
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpm reload -n")
    hl.exec_cmd("dbus-update-activation-environment --all")
    hl.exec_cmd("sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Desktop shell
    hl.exec_cmd("noctalia")

    -- Boot lock: wait for the shell's IPC, then lock. If Noctalia never
    -- comes up (15s), fall back to hyprlock so the session is never left
    -- unlocked on an autologin, remote-access machine.
    hl.exec_cmd([[sh -c 'i=0; while [ $i -lt 30 ]; do noctalia msg status >/dev/null 2>&1 && exec noctalia msg session lock; i=$((i+1)); sleep 0.5; done; exec hyprlock']])

    -- Audio
    hl.exec_cmd("easyeffects --hide-window --service-mode")

    -- Clipboard history: Noctalia ships its own clipboard panel (SUPER+V),
    -- so no cliphist watchers here.

    -- Cursor
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
end)
