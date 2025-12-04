#!/bin/sh

pkill picom

# set resolution
# check with xrandr
xrandr --output eDP --mode 2560x1600 --rate 165.00 --scale 0.75x0.75

picom -b
polybar main &

# Auto-lock after 10 minutes of inactivity
xautolock -time 10 -locker xsecurelock &

feh --bg-max ~/images/wallpapers/7183392_2612299_creepincrawl.png
polybar &
pgrep -x sxhkd > /dev/null || sxhkd &

#monitor
bspc monitor -d          

#window information
bspc config border_width 2
bspc config window_gap 10

bspc config normal_border_color "#4f415b"
bspc config focused_border_color "#d374f0"
bspc config active_border_color "#d05ef2"
bspc config urgent_border_color "#A54242"

bspc config split_ratio 0.5
bspc config borderless_monocle false
bspc config gapless_monocle false
bspc config single_monocle false

bspc config pointer_follows_monitor true
bspc config focus_follows_pointer true
