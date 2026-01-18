autoload -U colors && colors
setopt promptsubst

ZSH_PLUGINS_PATH="$HOME/.config/zsh/plugins"

# source $HOME/.config/zsh/plugins/git.zsh
# source "$ZSH_PLUGINS_PATH/git-prompt/git-prompt.plugin.zsh"
# source $HOME/.config/zsh/agnoster.zsh-theme
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# Prompt theme
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}\uE0A0"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%B%{$fg[green]%}%n%{$fg[green]%}@%{$fg[green]%}%M:%{$fg_bold[blue]%}%~%{$reset_color%}$ '
# RPROMPT='$(git_prompt_info)'
# PROMPT='%{$fg[green]%}%n@%m:%{$fg_bold[blue]%}%2~ $(git_super_status)%{$reset_color%}%(!.#.$) '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="›%{$reset_color%}"

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

# source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

# Edit line in vim with ctrl-r:
autoload edit-command-line; zle -N edit-command-line
bindkey '^x' edit-command-line

# bindkey -e

# Use vim keys in tab complete menu:
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char

# Disable directory underlining
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

source "$HOME/.config/zsh/.zsh_aliases"
source "$HOME/.config/zsh/.zsh_binds"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source <(fzf --zsh)
