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

export PATH=$HOME/.local/go/bin:$HOME/go/bin:$HOME/.local/share/flatpak/exports/bin:$HOME/.local/bin:$HOME/Code/ccc/main/bin:$HOME/.local/bin:$PATH:$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$HOME/.npm_packages/bin:/opt/DbVisualizer
export MANPATH=$MANPATH:/home/ib/.linuxbrew/share/man:$HOME/.local/share/man
export INFOPATH=$INFOPATH:/home/ib/.linuxbrew/share/info

# export LD_LIBRARY_PATH=$HOME/.linuxbrew/lib
# export LIBRARY_PATH=$HOME/.linuxbrew/lib
# export CPLUS_INCLUDE_PATH=:$HOME/.linuxbrew/include:$HOME/.ccc/x/u/branchr/runtime+bm.runtime-8.8-576f821c-64r/install/opt/exasol/runtime-8.8.0/include

export TEXINPUTS=$HOME/.local/share/texmf:
