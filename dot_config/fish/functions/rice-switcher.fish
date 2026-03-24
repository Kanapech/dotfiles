function rice-switcher
    # Check if already running
    if pgrep -f "quickshell.*riceswitcher" > /dev/null
        return 0
    end
    quickshell -c riceswitcher
end
