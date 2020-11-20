# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ -f "$HOME/.bashrc.local.before" ]]; then
    source ~/.bashrc.local.before
fi

source "$HOME/.config/shells/config.sh"
source "$HOME/.config/shells/env"
source "$HOME/.config/shells/env.sh"
source "$HOME/.config/bash/env"
source "$HOME/.config/shells/functions.sh"
source "$HOME/.config/shells/aliases"
source "$HOME/.config/bash/config.bash"

prune-history
