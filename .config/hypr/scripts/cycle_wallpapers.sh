#!/bin/bash

DIR="$HOME/.config/hypr/Pupsiki"
LASTPATH="$HOME/.last_wallpaper"

if ! swww query >/dev/null 2>&1; then
    swww-daemon &
    # Give it a second to create the socket
    sleep 1
fi
WALLPAPERS=($(find "$DIR" -type f | sort))

if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    notify-send "Wallpaper Error" "No images in $DIR"
    exit 1
fi

LAST_WALLPAPER=$(cat "$LASTPATH" 2>/dev/null)
NEXT_INDEX=0

for i in "${!WALLPAPERS[@]}"; do
   if [[ "${WALLPAPERS[$i]}" == "$HOME/.config/hypr/Pupsiki/$LAST_WALLPAPER" ]]; then
       NEXT_INDEX=$(( (i + 1) % ${#WALLPAPERS[@]} ))
       break
   fi
done

NEW_WALL="${WALLPAPERS[$NEXT_INDEX]}"
NEW_FILENAME="${NEW_WALL##*/}"

swww img "$HOME/.config/hypr/Pupsiki/$NEW_FILENAME" --transition-type wipe --transition-duration 0.4 --transition-fps 90 --transition-step 180 -o eDP-1
echo "$NEW_FILENAME" > "$LASTPATH"

