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
    plugin = {
        --hyprbars = {
            -- Honestly idk if it works like css, but well, why not
            --bar_text_font = "Google Sans Flex Medium, Rubik, Geist, AR One Sans, Reddit Sans, Inter, Roboto, Ubuntu, Noto Sans, sans-serif",
           -- bar_height = 30,
           -- bar_padding = 10,
           -- bar_button_padding = 5,
           -- bar_precedence_over_border = true,
           -- bar_part_of_window = true,
           -- bar_color = "rgba(131313FF)",
           -- col = {
           --     text = "rgba(e2e2e2FF)",
           -- },
       -- },
    },
})

-- example buttons (R -> L)
--hl.plugin.hyprbars.add_button({ bg_color = "rgb(e2e2e2)", size = 13, icon = "󰖭", action = "hyprctl dispatch killactive" })
--hl.plugin.hyprbars.add_button({ bg_color = "rgb(e2e2e2)", size = 13, icon = "󰖯", action = "hyprctl dispatch fullscreen 1" })
--hl.plugin.hyprbars.add_button({ bg_color = "rgb(e2e2e2)", size = 13, icon = "󰖰", action = "hyprctl dispatch movetoworkspacesilent special" })

hl.window_rule({
    match = { pin = true },
    border_color = "rgba(ffb960AA) rgba(ffb96077)",
})
