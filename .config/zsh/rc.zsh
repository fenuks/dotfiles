setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt COMPLETE_ALIASES
setopt EXTENDED_GLOB

source_if_exists /usr/share/fzf/key-bindings.zsh
source_if_exists /usr/share/fzf/completion.zsh
source_if_exists /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  bindkey '^g' autosuggest-accept
fi

bindkey -v # use vim-mode
bindkey '^k' history-beginning-search-backward
bindkey '^j' history-beginning-search-forward
bindkey '^P' reverse-menu-complete
bindkey '^N' menu-expand-or-complete
bindkey -s '^o' ' rcd'
bindkey -s '^l' ' clear'
# autoload -U colors && colors
autoload -Uz compinit
zstyle ':completion:*' menu select
compinit

zstyle :compinstall filename ~/.config/zsh/.zshrc

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

if command -v starship > /dev/null; then
    eval "$(starship init zsh)"
fi
