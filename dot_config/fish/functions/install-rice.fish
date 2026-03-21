function install-rice
    set -l rice $argv[1]
    set -l rices_file ~/.local/share/chezmoi/.rices
    set -l rice_configs ~/.local/share/chezmoi/rice-configs
    set -l rice_dir ~/.local/share/$rice

    if ! test -d $rice_dir
        echo "Rice '$rice' not found in ~/.local/share/"
        return 1
    end

    # Add to registry if not already there
    if ! string match -q "*$rice*" (cat $rices_file)
        echo -n " $rice" >> $rices_file
    end

    # Create hyprland config snippet
    if test -f $rice_dir/hypr/hyprland.conf
        cp $rice_dir/hypr/hyprland.conf $rice_configs/$rice.conf
        echo "Hyprland config snippet created for $rice"
    else
        echo "No hyprland.conf found in $rice_dir/hypr/, skipping snippet creation"
    end

    # Auto-detect shell start command
    if test -f $rice_dir/hypr/hyprland/execs.conf
        set -l start_cmd (
            grep -E "exec-once.*(shell|qs -c|quickshell)" \
            $rice_dir/hypr/hyprland/execs.conf \
            | grep -v "^#" \
            | head -1 \
            | string replace -r '^\s*exec-once\s*=\s*' ''
        )

        if test -n "$start_cmd"
            # Save start command
            echo $start_cmd > $rice_configs/$rice.start
            echo "Start command detected: $start_cmd"

            # Generate stop command from first two words of start command
            set -l process (echo $start_cmd | string split ' ' | head -2 | string join ' ')
            echo "pkill -f '$process'" > $rice_configs/$rice.stop
            echo "Stop command generated: pkill -f '$process'"
        else
            echo "Could not auto-detect start command. Here are all exec-once lines:"
            grep -v "^#" $rice_dir/hypr/hyprland/execs.conf | grep "exec-once"

            echo "Enter the start command manually:"
            read -l manual_start
            echo $manual_start > $rice_configs/$rice.start

            echo "Enter the stop command manually (e.g. pkill -f 'qs -c'):"
            read -l manual_stop
            echo $manual_stop > $rice_configs/$rice.stop
        end
    else
        echo "No execs.conf found."

        echo "Enter the start command manually:"
        read -l manual_start
        echo $manual_start > $rice_configs/$rice.start

        echo "Enter the stop command manually (e.g. pkill -f 'qs -c'):"
        read -l manual_stop
        echo $manual_stop > $rice_configs/$rice.stop
    end

    echo "Rice '$rice' registered. Run its installer then use switch-rice $rice."
end
