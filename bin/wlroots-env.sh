#!/bin/bash
if [[ "$DESKTOP_SESSION" == "mango" ]]; then
  export WAYLAND_DISPLAY=wayland-0
  export XDG_CURRENT_DESKTOP=wlroots
fi
