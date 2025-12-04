#!/usr/bin/env bash

PERCENTAGE="5"

case "$1" in
    up)
        pamixer --increase "$PERCENTAGE"
        ;;
    down)
        pamixer --decrease "$PERCENTAGE"
        ;;
    mute)
        pamixer --toggle-mute
        ;;
esac

polybar-msg action volume hook 0