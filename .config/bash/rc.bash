# bind 'set show-all-if-ambiguous on'
# bind 'TAB:menu-complete'
shopt -s globstar
# append to history from multiple terminals
shopt -s histappend
# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space
# Save multi-line commands as one command
shopt -s cmdhist
# change directory without explicit cd
shopt -s autocd
# clear screen pernamently
bind '"\C-l": " clear && printf \"\\e[3J\""'

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
source_if_exists /usr/share/fzf/completion.bash
source_if_exists /usr/share/fzf/key-bindings.bash
# unbind C-z in fzf keybindings
bind -m vi-command -r '\C-z'
bind -m vi-insert -r '\C-z'
bind -x '"\C-z": " maybe_fg"'

complete -o default -o nospace -F _docker_compose dc
if [[ -r "$HOME/.config/fzf/completions/git.sh" ]]; then 
    source "$HOME/.config/fzf/completions/git.sh"
    complete -o default -o nospace -F _fzf_complete_git cgit
    complete -o default -o nospace -F _fzf_complete_git g
else
    complete -o default -o nospace -F __git_wrap__git_main cgit
    complete -o default -o nospace -F __git_wrap__git_main g
fi
source_if_exists "$HOME/.config/fzf/completions/hg.sh"
source_if_exists "$HOME/.config/fzf/completions/docker.sh"

PS0="\e[2 q" # reset cursor to normal before program runs

if command -v starship > /dev/null; then
    eval "$(starship init bash)"
fi

if command -v zoxide > /dev/null; then
    eval "$(zoxide init bash)"
fi

prune-history
