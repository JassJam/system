#!/usr/bin/env bash

PERCENTAGE="5%"

case "$1" in
    up)
        brightnessctl set "$PERCENTAGE+"
        ;;
    down)
        brightnessctl set "$PERCENTAGE-"
        ;;
esac

polybar-msg action brightness hook 0