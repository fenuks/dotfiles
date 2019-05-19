HISTSIZE=10000
SAVEHIST=10000
bindkey -v
zstyle :compinstall filename ~/.config/zsh/.zshrc

autoload -Uz compinit
compinit

source ~/.config/shells/functions.sh
source ~/.config/shells/env.sh
source ~/.config/shells/aliases.sh
source ~/.config/shells/config.sh

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
