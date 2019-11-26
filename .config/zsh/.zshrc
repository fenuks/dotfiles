source ~/.config/shells/env
source ~/.config/shells/env.sh
source ~/.config/shells/functions.sh
source ~/.config/shells/aliases
source ~/.config/shells/config.sh
HISTFILE=~/.cache/zsh_history
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS


source_if_exists /usr/share/fzf/key-bindings.zsh
source_if_exists /usr/share/fzf/completion.zsh

bindkey -v # use vim-mode
KEYTIMEOUT=1 # vim-mode timeout
bindkey '^k' history-beginning-search-backward
bindkey '^j' history-beginning-search-forward
bindkey '^P' reverse-menu-complete
bindkey '^N' menu-expand-or-complete
bindkey -s '^o' ' rcd'
bindkey -s '^l' ' clear'
# autoload -U colors && colors
autoload -Uz compinit
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' menu select
compinit

zstyle :compinstall filename ~/.config/zsh/.zshrc

ZSH_THEME="random"
alias -s {yml,yaml}=vim

function zle-keymap-select {
  # Change cursor shape for different vi modes.
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

function zle-line-init  {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}

echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

zle -N zle-keymap-select
zle -N zle-line-init

source ~/.config/zsh/zshrc.local.after
