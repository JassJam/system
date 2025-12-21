#!/usr/bin/env bash

hidden_windows=$(bspc query -N -n .hidden)

if [ -z "$hidden_windows" ]; then
    exit 0
fi

menu=""
while read -r id; do
    title=$(xtitle "$id")
    menu="$menu$id: $title\n"
done <<< "$hidden_windows"

selected=$(echo -e "$menu" | rofi -dmenu -p "Unhide window:" | cut -d: -f1)
if [ -n "$selected" ]; then
    bspc node "$selected" -g hidden=off -f
fi