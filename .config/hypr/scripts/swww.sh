!/usr/bin/bash
#start swww

WALLPAPERS_DIR="$HOME/.config/hypr/Pupsiki"
WALLPAPER=$(find "$WALLPAPERS_DIR" -type f | shuf -n 1)
swww img "$WALLPAPER"
