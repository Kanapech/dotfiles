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

    # Create hyprland config snippet as template
    if test -f $rice_dir/hypr/hyprland.conf
        sed "s|$HOME|{{ .chezmoi.homeDir }}|g" \
            $rice_dir/hypr/hyprland.conf \
            > $rice_configs/$rice.conf.tmpl
        # Render it immediately too
        chezmoi execute-template < $rice_configs/$rice.conf.tmpl > $rice_configs/$rice.conf
        echo "Hyprland config snippet created for $rice"
    else
        echo "No hyprland.conf found in $rice_dir/hypr/, skipping snippet creation"
    end

    # Auto-detect shell start command
    if test -f $rice_dir/hypr/hyprland/execs.conf
        set -l raw_cmd (
            grep -E "exec-once.*(shell|qs -c|quickshell)" \
            $rice_dir/hypr/hyprland/execs.conf \
            | grep -v "^#" \
            | head -1 \
            | string replace -r '^\s*exec-once\s*=\s*' ''
        )

        if test -n "$raw_cmd"
            echo "uwsm app -t service -- $raw_cmd" > $rice_configs/$rice.start
            echo "Start command detected: $raw_cmd"

            set -l process (echo $raw_cmd | string split ' ' | head -2 | string join ' ')
            echo "pkill -f '$process'" > $rice_configs/$rice.stop
            echo "Stop command generated: pkill -f '$process'"
        else
            echo "Could not auto-detect start command. Here are all exec-once lines:"
            grep -v "^#" $rice_dir/hypr/hyprland/execs.conf | grep "exec-once"

            echo "Enter the raw start command manually (without uwsm prefix):"
            read -l manual_start
            echo "uwsm app -t service -- $manual_start" > $rice_configs/$rice.start

            echo "Enter the stop command manually (e.g. pkill -f 'qs -c'):"
            read -l manual_stop
            echo $manual_stop > $rice_configs/$rice.stop
        end
    else
        echo "No execs.conf found."

        echo "Enter the raw start command manually (without uwsm prefix):"
        read -l manual_start
        echo "uwsm app -t service -- $manual_start" > $rice_configs/$rice.start

        echo "Enter the stop command manually (e.g. pkill -f 'qs -c'):"
        read -l manual_stop
        echo $manual_stop > $rice_configs/$rice.stop
    end

    echo "Rice '$rice' registered. Run its installer then use switch-rice $rice."
end
