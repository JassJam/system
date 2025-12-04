#!/usr/bin/env bash

hardware_file="./core/hardware-configuration.nix"

# Generate hardware config and filter out Docker overlay mounts
sudo nixos-generate-config --show-hardware-config 2>/dev/null | \
  sed '/\/var\/lib\/docker\/overlay2\//,/^$/d' > "$hardware_file"

if [ -f "$hardware_file" ]; then
    echo "${OK} Hardware configuration successfully generated"
else
    echo "${WARN} Failed to generate hardware configuration."
    exit 1
fi