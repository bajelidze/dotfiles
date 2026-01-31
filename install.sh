#!/bin/bash

# set -e

SCRIPT_DEST_DIR="/usr/local/bin"

# Usage: make_home_symlink path_to_file name_of_file_in_home_to_symlink_to
make_home_symlink() {
    if [ -z "$1" ]; then
        >&2 echo "make_home_symlink: missing first argument: path to file"
        exit 1
    fi

    THIS_DOTFILE_PATH="$PWD/$1"
    if [ -z "$2" ]; then
        HOME_DOTFILE_PATH="$HOME/$1"
    else
        HOME_DOTFILE_PATH="$HOME/$2"
    fi

    printf "Installing %s into %s" "$1" "$HOME_DOTFILE_PATH"

    if [ -L "$HOME_DOTFILE_PATH" ]; then
        echo " skipping, target is already a symlink"
        return
    fi

    if [ -f "$HOME_DOTFILE_PATH" ] && [ ! -L "$HOME_DOTFILE_PATH" ]; then
        printf " You already have a regular file at %s. Do you want to remove it? (y/n) " "$HOME_DOTFILE_PATH"
        read -r response
        if [ "$response" = "y" ] || [ "$response" = "Y" ]; then
            rm "$HOME_DOTFILE_PATH"
        else
            return
        fi
    fi

    ln -s "$THIS_DOTFILE_PATH" "$HOME_DOTFILE_PATH" 2>/dev/null
    echo "Done"
}

make_script_symlink() {
    local -a scripts=("scripts/"*)

    for script in "${scripts[@]}"; do
        src="$PWD/$script"
        dest="$SCRIPT_DEST_DIR/${script/scripts\/}"
        echo "Installing $src into $dest"
        sudo ln -s "$src" "$dest"
    done
}

mkdir -p "$HOME/.cache/zsh"

dotfiles=(
    ".config/lf"
    ".config/yazi"
    ".config/.diricons"
    ".config/nvim"
    ".config/polybar"
    ".config/zsh"
    ".config/alacritty"
    ".config/i3"
    ".config/redshift.conf"
    ".config/picom.conf"
    ".config/ranger"
    ".config/mpv"
    ".config/mimeapps.list"
    ".config/foot"
    ".config/waybar"
    ".config/rofi"
    ".config/mango"
    ".tmux.conf"
    ".zshenv"
    ".Xresources"
    ".urxvt"
    ".wegorc"
    ".gitconfig"
    ".xinitrc"
)

for dotfile in "${dotfiles[@]}"; do
    make_home_symlink "$dotfile"
done

sudo ln -s "$HOME/.config/lf/lfrun" "/usr/local/bin" 2> /dev/null
make_script_symlink
