#!/bin/sh

if hyprctl monitors | grep -Eq '[[:space:]]HDMI-[A-Z]+-[0-9]+'; then
  case "$1" in
  open)
    hyprctl keyword monitor "eDP-1,preferred,auto,1"
    ;;
  close)
    hyprctl keyword monitor "eDP-1,disable"
    # Laptop display is enabled right before before suspension in hypridle to avoid no display on resume
    # eg: external monitor connected > lid closed > external display disconnected > no display on resume
    ;;
  esac
fi
