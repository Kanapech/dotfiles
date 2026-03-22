function switch-rice
    set -l rice $argv[1]
    set -l rices_file ~/.local/share/chezmoi/.rices
    set -l rice_configs ~/.local/share/chezmoi/rice-configs
    set -l rices (cat $rices_file | string split ' ')

    if ! contains $rice $rices
        echo "Unknown rice '$rice'. Available: $rices"
        return 1
    end

    echo "Stopping current rice shells..."
    for r in $rices
        if test -f $rice_configs/$r.stop
            fish -c (cat $rice_configs/$r.stop)
        end
    end

    sleep 0.5

    echo "Applying $rice config..."
        sed -i "s/qsConfig = .*/qsConfig = \"$rice\"/" ~/.local/share/chezmoi/.chezmoidata.toml
    
        # Remove old rendered conf to avoid inconsistent state
        rm -f ~/.local/share/chezmoi/rice-configs/$rice.conf
    
        # Render rice conf template if it exists
        if test -f ~/.local/share/chezmoi/rice-configs/$rice.conf.tmpl
            if ! chezmoi execute-template < ~/.local/share/chezmoi/rice-configs/$rice.conf.tmpl > ~/.local/share/chezmoi/rice-configs/$rice.conf
                echo "Error: failed to render $rice config template"
                return 1
            end
        end

    if ! chezmoi apply ~/.config/hypr/hyprland.conf
        echo "Error: chezmoi apply failed"
        return 1
    end

    echo "Reloading Hyprland..."
    if ! hyprctl reload
        echo "Error: hyprctl reload failed"
        return 1
    end

    sleep 0.5

    echo "Starting $rice shell..."
    if ! test -f $rice_configs/$rice.start
        echo "Error: no start script found for $rice"
        return 1
    end

    set -l start_cmd (cat $rice_configs/$rice.start)
    if ! fish -c "$start_cmd"
        echo "Error: failed to start $rice shell"
        return 1
    end

    notify-send -i preferences-desktop "Rice switched" "Now running $rice"
    echo "Switched to $rice!"
end
