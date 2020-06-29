# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ -f "$HOME/.bashrc.local.before" ]]; then
    source ~/.bashrc.local.before
fi

# set -e # exit on non-zero code
# set -o nounset # error when non-set variable is accessed
set -o pipefail # return code of failed pipeline command


source "$HOME/.config/shells/env"
source "$HOME/.config/shells/env.sh"
source "$HOME/.config/bash/env"
source "$HOME/.config/shells/functions.sh"
source "$HOME/.config/shells/aliases"
source "$HOME/.config/shells/config.sh"

# bash-specific things
source_if_exists /etc/bashrc

# bind 'set show-all-if-ambiguous on'
# bind 'TAB:menu-complete'
shopt -s globstar
# append to history from multiple terminals
shopt -s histappend
prune-history
# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space
# Save multi-line commands as one command
shopt -s cmdhist
# clear screen pernamently
bind '"\C-l": " clear && printf \"\\e[3J\""'
stty susp undef
bind '"\C-z":"fg\015"'

# bind fzf git keys
bind '"\er": redraw-current-line'
bind '"\C-g\C-f": "$(gf)\e\C-e\er"'
bind '"\C-g\C-b": "$(gb)\e\C-e\er"'
bind '"\C-g\C-t": "$(gt)\e\C-e\er"'
bind '"\C-g\C-h": "$(gh)\e\C-e\er"'
bind '"\C-g\C-r": "$(gr)\e\C-e\er"'

# completion
complete -cf sudo
complete -cf man

source_if_exists /usr/share/git/completion/git-completion.bash
source_if_exists /usr/share/bash-completion/completions/hg
source_if_exists /usr/share/bash-completion/completions/docker
source_if_exists /usr/share/bash-completion/completions/docker-compose
source_if_exists /usr/share/fzf/key-bindings.bash
source_if_exists /usr/share/fzf/completion.bash
complete -o default -o nospace -F _docker_compose dc
# [[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
if [[ -r "$HOME/.config/fzf/completions/git.sh" ]]; then 
    source "$HOME/.config/fzf/completions/git.sh"
    complete -o default -o nospace -F _fzf_complete_git cgit
    complete -o default -o nospace -F _fzf_complete_git g
else
    complete -o default -o nospace -F _git cgit
    complete -o default -o nospace -F _git g
fi
source_if_exists "$HOME/.config/fzf/completions/hg.sh"
source_if_exists "$HOME/.config/fzf/completions/docker.sh"
source_if_exists "$HOME/.enhancd/init.sh"

source_if_exists "$HOME/.bashrc.local.after"

if [[ -x "$(which starship)" ]]; then
    eval "$(starship init bash)"
fi
