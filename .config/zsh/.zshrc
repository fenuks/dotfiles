HISTSIZE=10000
SAVEHIST=10000
bindkey -v
zstyle :compinstall filename ~/.config/zsh/.zshrc

autoload -Uz compinit
compinit

source ~/.config/shells/env
source ~/.config/shells/env.sh
source ~/.config/shells/functions.sh
source ~/.config/shells/aliases
source ~/.config/shells/config.sh

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

ZSH_THEME="random"
