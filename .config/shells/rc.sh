# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source "$HOME/.config/shells/config.sh"
source "$HOME/.config/shells/env"
source "$HOME/.config/shells/env.sh"
source "$HOME/.config/shells/$SHELL_TYPE/env.$SHELL_TYPE"
source "$HOME/.config/shells/functions.sh"
source_if_exists "$HOME/.config/shells/functions.$SHELL_TYPE"
source "$HOME/.config/shells/aliases"
source "$HOME/.config/shells/aliases.sh"
source "$HOME/.config/shells/$SHELL_TYPE/rc.$SHELL_TYPE"

source_if_exists "$HOME/.config/shells/localrc.after.sh"
source_if_exists "$HOME/.config/shells/$SHELL_TYPE/localrc.after.$SHELL_TYPE"

if [[ -f /usr/lib/libstderred.so ]]; then
    export LD_PRELOAD="/usr/lib/libstderred.so${LD_PRELOAD:+:${LD_PRELOAD}}"
fi
