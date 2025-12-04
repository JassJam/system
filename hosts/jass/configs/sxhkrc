# ============================================
# WINDOWS
# ============================================

# Launch terminal
super + Return
  kitty

# Launch floating terminal
super + shift + Return
  SCALE_W=60; \
  SCALE_H=60; \
  W=$(xrandr| grep '*'| head -1| cut -d'x' -f1 | tr -d ' '); \
  H=$(xrandr| grep '*'| head -1| cut -d'x' -f2 | cut -d' ' -f1 | tr -d ' '); \
  H=$((H * SCALE_H / 100)); \
  W=$((W * SCALE_W / 100)); \
  bspc rule -a floating-terminal state=floating rectangle=$((W))x$((H))+0+0 center=true && kitty --class floating-terminal

# Close window
super + q
  bspc node -c

# Kill window
super + shift + q
  bspc node -k

# Hide/minimize window
super + h
  bspc node -g hidden

# Show hidden windows menu
super + shift + h
  $HOME/.config/sxhkd/unhide_window.sh
  bspc node $(bspc query -N -n .hidden | rofi -dmenu -p "Unhide window:") -g hidden=off

# Toggle fullscreen
super + f
  bspc node -t ~fullscreen

# Set window to tiled
super + t
  bspc node -t tiled

# Set window to pseudo-tiled
super + shift + t
  bspc node -t pseudo_tiled

# Set window to floating
super + shift + f
  bspc node -t floating

# ============================================
# NAVIGATION
# ============================================

# Open application launcher
super + space
  rofi -show drun

# Switch to last focused desktop
alt + Tab
  bspc desktop -f last

# Focus next/previous window
super + ctrl + {Left,Right}
  bspc node -f {next,prev}.local

# Focus next/previous desktop
super + {Left,Right}
  bspc desktop -f {prev,next}.local

# Focus next/previous monitor
super + ctrl + {Up,Down}
  bspc monitor -f {next,prev}

# ============================================
# MOVING WINDOWS
# ============================================

# Move window to next/previous desktop
super + shift + {Left,Right}
  bspc node -d {prev,next}.local --follow

# Move window to next/previous monitor
super + shift + {Up,Down}
  bspc node -m {next,prev}

# Swap with next/previous window
super + alt + {Left,Right}
  bspc node -s {next,prev}.local

# ============================================
# DESKTOPS
# ============================================

# Add new desktop
super + alt + n
  bspc monitor -a 

# Remove current desktop
super + alt + r
  $HOME/.config/sxhkd/remove_desktop.sh

# ============================================
# SCREENSHOTS
# ============================================

# Screenshot full screen
super + shift + s
  (p="$HOME/images/screenshots"; mkdir -p "$p"; maim | tee "$p/$(date +%Y%m%d-%H%M%S).png" | xclip -selection clipboard -t image/png)

# Screenshot selected area
super + s
  (p="$HOME/images/screenshots"; mkdir -p "$p"; maim -s | tee "$p/$(date +%Y%m%d-%H%M%S).png" | xclip -selection clipboard -t image/png)

# ============================================
# SYSTEM
# ============================================

# Lock screen
super + l
  xsecurelock

# Open clipboard history
super + v
  cliphist list | rofi -dmenu | cliphist decode | xclip -selection clipboard

# Volume up
XF86AudioRaiseVolume
  $HOME/.config/sxhkd/volume_control.sh up

# Volume down
XF86AudioLowerVolume
  $HOME/.config/sxhkd/volume_control.sh down

# Toggle mute
XF86AudioMute
  $HOME/.config/sxhkd/volume_control.sh mute

# Brightness up
XF86MonBrightnessUp
  $HOME/.config/sxhkd/brightness_control.sh up

# Brightness down
XF86MonBrightnessDown
  $HOME/.config/sxhkd/brightness_control.sh down
