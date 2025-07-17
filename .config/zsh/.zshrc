autoload -U colors && colors
setopt promptsubst

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

fzf-file-open() { fzf --print0  }
zle -N fzf-file-open

PROMPT='%B%{$fg[green]%}%n%{$fg[green]%}@%{$fg[green]%}%M:%{$fg_bold[blue]%}%~%{$reset_color%}$ '

# History cache
HISTSIZE=3000
SAVEHIST=3000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files

# source $HOME/.config/zsh/plugins/zsh-vi-mode.zsh
source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Edit line in vim with ctrl-r:
autoload edit-command-line; zle -N edit-command-line
bindkey '^x' edit-command-line

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.config/zsh/plugins/fzf.zsh

# Disable directory underlining
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

source $HOME/.config/zsh/.zsh_aliases
source $HOME/.config/zsh/.zsh_binds

# source $HOME/.ccc/saas_helpers

export FZF_DEFAULT_OPTS='--layout reverse --height 40%'
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window up:3:hidden:wrap --bind 'ctrl-/:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --color header:italic --header 'Press CTRL-Y to copy command into clipboard'"

source $HOME/.zshenv
