HISTSIZE=10000
SAVEHIST=10000
export KEYTIMEOUT=1 # vim-mode timeout
bindkey -v # use vim-mode
bindkey '^P' up-history
bindkey '^N' down-history

zstyle :compinstall filename ~/.config/zsh/.zshrc

autoload -Uz compinit
compinit

source ~/.config/shells/env
source ~/.config/shells/env.sh
source ~/.config/shells/functions.sh
source ~/.config/shells/aliases
source ~/.config/shells/config.sh

source_if_exists /usr/share/fzf/key-bindings.zsh
source_if_exists /usr/share/fzf/completion.zsh

ZSH_THEME="random"

# vim-mode status indicator
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
