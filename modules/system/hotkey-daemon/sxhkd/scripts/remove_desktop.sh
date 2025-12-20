#!/usr/bin/env bash

current_desktop=$(bspc query -D -d focused --names)
prev_desktop=$(bspc query -D -d prev.local --names)

if [ "$current_desktop" = "$prev_desktop" ]; then
  echo "Cannot remove the only desktop."
  exit 1
fi

# Move all nodes from the current desktop to the previous desktop
for node in $(bspc query -N -d "$current_desktop"); do
  bspc node "$node" -d "$prev_desktop"
done
# Remove the current desktop
bspc desktop "$current_desktop" -r

# rename all desktops from 1 to N
# renaming a desktop invalidates the names, so we need to query again
desktops=$(bspc query -D | wc -l)
i=1
while [ $i -le $desktops ]; do
  desktop_name=$(bspc query -D | sed -n "${i}p")
  bspc desktop "$desktop_name" --rename ""
  i=$((i + 1))
done
