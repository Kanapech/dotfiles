function switch-rice
    set -l rice $argv[1]
    
    sed -i "s/qsConfig = .*/qsConfig = \"$rice\"/" ~/.local/share/chezmoi/.chezmoidata.toml
    chezmoi apply ~/.config/hypr/hyprland.conf
    
    pkill -f "caelestia shell"
    pkill -f "qs -c"
    sleep 0.5
    
    if test $rice = "ii"
        qs -c ii &
    else if test $rice = "caelestia"
        caelestia shell -d
    end
    
    hyprctl reload
end
