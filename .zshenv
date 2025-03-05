export ZDOTDIR="$HOME/.config/zsh"

if [[ -f ~/.config/.diricons ]]; then
	LF_ICONS="$(tr '\n' ':' <~/.config/.diricons)"
	export LF_ICONS
fi

export PATH=$PATH:$HOME/.npm-packages/bin:$HOME/Code/ccc/bin:$HOME/.local/bin:$HOME/go/bin

export GDK_DPI_SCALE=1.4
export GTK_THEME=Adwaita:dark
export EDITOR=nvim
