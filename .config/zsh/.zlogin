# if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
#   exec startx
# fi
# Start Sway on login on the first TTY
if [[ -z "$WAYLAND_DISPLAY" ]] && [[ "$(tty)" == "/dev/tty1" ]]; then
    exec mango
fi
