#!/bin/sh

# picom &

feh --bg-scale ~/Pictures/current

dwmblocks &
dunst &
nm-applet &
clipit -n &
xclip &
xrdb "$HOME/.Xresources"

# eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"

monitor

pasystray &

# Trigger a refresh of `volumectl`.
kill -44 "$(pidof dwmblocks)" > /dev/null 2>&1

exec dwm
