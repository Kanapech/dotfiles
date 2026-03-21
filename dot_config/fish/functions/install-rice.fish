function install-rice
    set -l rice $argv[1]
    set -l rices_file ~/.local/share/chezmoi/.rices

    # Add to registry if not already there
    if ! string match -q "*$rice*" (cat $rices_file)
        echo -n " $rice" >> $rices_file
    end

    echo "Rice '$rice' registered. Run its installer manually then use switch-rice $rice."
end
