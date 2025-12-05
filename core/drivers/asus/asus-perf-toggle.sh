#!/usr/bin/env bash

# Function to set profile and notify
set_profile() {
  local profile=$1
  local icon=$2
  local desc=$3
  
  asusctl profile -P "$profile" 2>/dev/null
  dunstify -u normal -i "$icon" -a "ASUS Power" -r 2593 "Power Profile" "Switched to <b>$profile</b>$desc"
}

# If argument provided, set specific profile
if [ $# -gt 0 ]; then
  case "$1" in
    perf|performance|p|P)
      set_profile "Performance" "battery-empty" ""
      ;;
    balanced|balance|b|B)
      set_profile "Balanced" "battery-good" ""
      ;;
    quiet|q|Q)
      set_profile "Quiet" "battery-full-charging" " (Battery Saver)"
      ;;
    *)
      echo "Usage: asus-toggle [perf|balanced|quiet|p|b|q]"
      echo "  perf, p       - Performance mode"
      echo "  balanced, b   - Balanced mode"
      echo "  quiet, q      - Quiet mode (Battery Saver)"
      echo ""
      echo "Without arguments, cycles through profiles."
      exit 1
      ;;
  esac
else
  # No argument: cycle through profiles
  cur=$(asusctl profile -p 2>/dev/null | grep -oP '(?<=Active profile is )\w+')
  case "$cur" in
    Performance)
      set_profile "Balanced" "battery-good" ""
      ;;
    Balanced)
      set_profile "Quiet" "battery-full-charging" " (Battery Saver)"
      ;;
    *)
      set_profile "Performance" "battery-empty" ""
      ;;
  esac
fi
