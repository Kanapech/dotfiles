function uninstall-rice
    set -l rice $argv[1]
    set -l rice_dir ~/.local/share/$rice
    set -l rices_file ~/.local/share/chezmoi/.rices
    set -l rice_configs ~/.local/share/chezmoi/rice-configs

    if ! test -d $rice_dir
        echo "Rice '$rice' not found in ~/.local/share/"
        return 1
    end

    # Switch away if currently active
    set -l current (cat ~/.local/share/chezmoi/.chezmoidata.toml | grep qsConfig | cut -d'"' -f2)
    if test "$current" = "$rice"
        set -l other (cat $rices_file | string split ' ' | grep -v $rice | head -1)
        if test -z "$other"
            echo "No other rice to switch to — aborting."
            return 1
        end
        echo "Switching to $other first..."
        switch-rice $other
    end

    # Auto-detect and remove symlinks pointing to this rice
    echo "Removing symlinked configs..."
    for link in ~/.config/*
        if test -L $link
            set -l target (readlink -f $link 2>/dev/null)
            if string match -q "$rice_dir*" $target
                echo "Removing $link"
                rm $link
                # If it was fish, restore it as a real directory
                if string match -q "*fish" $link
                    mkdir -p ~/.config/fish/functions
                    chezmoi apply ~/.config/fish
                end
            end
        end
    end

    # Remove user config dir if exists
    if test -d ~/.config/$rice
        echo "Removing ~/.config/$rice..."
        rm -rf ~/.config/$rice
    end

    # Remove quickshell profile if exists
    if test -d ~/.config/quickshell/$rice
        echo "Removing quickshell profile..."
        chezmoi forget ~/.config/quickshell/$rice 2>/dev/null
        rm -rf ~/.config/quickshell/$rice
    end

    # Remove rice-configs files
    echo "Removing rice-configs files..."
    rm -f $rice_configs/$rice.conf
    rm -f $rice_configs/$rice.start
    rm -f $rice_configs/$rice.stop

    # Remove from rices registry
    string replace -r "\b$rice\b" '' (cat $rices_file) | string trim > $rices_file

    # Remove the rice directory
    echo "Removing $rice_dir..."
    rm -rf $rice_dir

    # Uninstall only top-level rice packages
    set -l pkgs (paru -Q | grep "^$rice" | awk '{print $1}')
    if test -n "$pkgs"
        echo "Uninstalling packages: $pkgs"
        paru -Rn $pkgs

        # Show orphaned deps for manual review
        set -l orphans (paru -Qdtq)
        if test -n "$orphans"
            echo ""
            echo "These packages may now be orphaned, review and remove manually if needed:"
            echo $orphans
        end
    end

    echo "Done! '$rice' has been uninstalled."
end
