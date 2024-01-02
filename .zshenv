declare _SHELL="$(basename "$SHELL")"

# gcloud env vars and autocompletion
if [[ "$_SHELL" == "zsh" ]]; then
  if [[ -f $HOME'/.local/google-cloud-sdk/path.zsh.inc' ]]; then
    source $HOME'/.local/google-cloud-sdk/path.zsh.inc'
  fi

  if [[ -f $HOME'/.local/google-cloud-sdk/completion.zsh.inc' ]]; then
    source $HOME'/.local/google-cloud-sdk/completion.zsh.inc'
  fi
elif [[ "$_SHELL" == "bash" ]]; then
  if [[ -f '/home/ib/.local/google-cloud-sdk/path.bash.inc' ]]; then
    source '/home/ib/.local/google-cloud-sdk/path.bash.inc'
  fi

  if [[ -f '/home/ib/.local/google-cloud-sdk/completion.bash.inc' ]]; then
    source '/home/ib/.local/google-cloud-sdk/completion.bash.inc'
  fi
fi

export EDITOR=nvim
export BAT_THEME="Visual Studio Dark+"
export ZDOTDIR="$HOME/.config/zsh"
export BROWSER=firefox
export GOROOT=~/.local/go

export HOMEBREW_PREFIX="/home/ib/.linuxbrew";
export HOMEBREW_CELLAR="/home/ib/.linuxbrew/Cellar";
export HOMEBREW_REPOSITORY="/home/ib/.linuxbrew/Homebrew";
export HOMEBREW_SHELLENV_PREFIX="/home/ib/.linuxbrew";

export PATH=$HOME/.local/go/bin:$HOME/go/bin:$HOME/.local/share/flatpak/exports/bin:$HOME/.local/bin:$HOME/Code/ccc/main/bin:$HOME/.local/bin:$PATH:/home/ib/.linuxbrew/bin:/home/ib/.linuxbrew/sbin
export MANPATH=$MANPATH:/home/ib/.linuxbrew/share/man:$HOME/.local/share/man
export INFOPATH=$INFOPATH:/home/ib/.linuxbrew/share/info

export TEXINPUTS=$HOME/.local/share/texmf:
