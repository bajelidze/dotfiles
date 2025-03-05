#!/bin/sh

# picom &
dwmblocks &
dunst &
nm-applet &
clipit -n &
xclip &
xrdb "$HOME/.Xresources"

eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"

pasystray &

# Trigger a refresh of `volumectl`.
kill -44 "$(pidof dwmblocks)" > /dev/null 2>&1

xinput set-prop 'CIRQ1080:00 0488:1054 Touchpad' 'libinput Natural Scrolling Enabled' 1
xinput set-prop 'CIRQ1080:00 0488:1054 Touchpad' 'libinput Scrolling Pixel Distance' 10
xinput set-prop 'CIRQ1080:00 0488:1054 Touchpad' 'libinput Tapping Enabled' 1

feh --bg-scale ~/Pictures/current

exec dwm
