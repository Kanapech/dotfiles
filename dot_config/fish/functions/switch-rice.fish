function switch-rice
    set -l rice $argv[1]
    set -l rices_file ~/.local/share/chezmoi/.rices
    set -l rice_configs ~/.local/share/chezmoi/rice-configs
    set -l rices (cat $rices_file | string split ' ')

    if ! contains $rice $rices
        echo "Unknown rice '$rice'. Available: $rices"
        return 1
    end

    # Stop all running rice shells using their stop scripts
    for r in $rices
        if test -f $rice_configs/$r.stop
            fish -c (cat $rice_configs/$r.stop)
        end
    end

    sleep 0.5

    # Update chezmoi profile and apply
    sed -i "s/qsConfig = .*/qsConfig = \"$rice\"/" ~/.local/share/chezmoi/.chezmoidata.toml
    chezmoi apply ~/.config/hypr/hyprland.conf

    # Start new shell via uwsm
    set -l start_cmd (cat $rice_configs/$rice.start)
    fish -c "$start_cmd"

    hyprctl reload
end
