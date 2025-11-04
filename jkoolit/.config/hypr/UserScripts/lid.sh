#!/bin/sh

# check if an external HDMI monitor is connected
EXTERNAL_MONITOR_CONNECTED=$(hyprctl monitors | grep -Eq '[[:space:]]HDMI-[A-Z]+-[0-9]+' && echo true || echo false)
case "$1" in
open)
  # always enable eDP-1 when the lid is opened. This prevents the screen from remaining disabled unexpectedly
  # for instance if the external monitor was disconnected or after a restart.
  hyprctl keyword monitor "eDP-1,preferred,auto,1"
  ;;
close)
  if [ "$EXTERNAL_MONITOR_CONNECTED" = "true" ]; then
    # Only disable eDP-1 if an external monitor is connected (clamshell mode)
    hyprctl keyword monitor "eDP-1,disable"
  fi
  ;;
esac
