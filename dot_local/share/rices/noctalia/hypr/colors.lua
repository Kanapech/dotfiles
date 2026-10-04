-- Compositor-side colors. The shell palette is Noctalia's — pick one with:
--   noctalia msg color-scheme-set builtin Noctalia
-- (or wallpaper-driven: noctalia msg color-scheme-set wallpaper m3-content)
hl.config({
    general = {
        col = {
            active_border = "rgba(91919177)",
            inactive_border = "rgba(47474755)",
        },
    },
    misc = {
        background_color = "rgba(131313FF)",
    },
})
hl.window_rule({
    match = { pin = true },
    border_color = "rgba(ffb960AA) rgba(ffb96077)",
})
