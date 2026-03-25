function rice-switcher
    set -l lockfile /tmp/riceswitcher.lock
    set -l now (date +%s)
    
    # Check if we triggered recently (debounce 300ms)
    if test -f $lockfile
        set -l last (cat $lockfile)
        if test (math $now - $last) -lt 1
            return 0
        end
    end
    
    # Update timestamp
    echo $now > $lockfile
    
    # Toggle behavior
    if pgrep -f "quickshell.*-c.*riceswitcher" >/dev/null 2>&1
        pkill -f "quickshell.*-c.*riceswitcher"
        return 0
    end
    
    quickshell -c riceswitcher &
    disown
end
