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
bind '"\C-l": "\C-u clear && printf \"\\e[3J\""'

# bind fzf git keys
bind -x '"\C-gf": " gf_bash"'
bind -x '"\C-gb": " gb_bash"'
bind -x '"\C-gt": " gt_bash"'
bind -x '"\C-gh": " gh_bash"'
bind -x '"\C-gr": " gr_bash"'

# completion
complete -cf sudo
complete -cf man

source_if_exists /usr/share/git/completion/git-completion.bash
source_if_exists /usr/share/bash-completion/completions/hg
source_if_exists /usr/share/bash-completion/completions/docker
source_if_exists /usr/share/fzf/completion.bash
source_if_exists /usr/share/fzf/key-bindings.bash
# unbind C-z in fzf keybindings
bind -m vi-command -r '\C-z'
bind -m vi-insert -r '\C-z'
bind -m emacs-standard -r '\C-z'

bind -x '"\C-z": " maybe_fg"'
bind -x '"\C-z": " maybe_fg"'
bind -x '"\ec": "__fzf_cd__"'
bind -x '"\C-x": " dir_bash"'

# extended keys can be bind as well
# bind c-;
# bind -x '"\e[59;5u": " gr_bash"'

if [[ -r "$HOME/.config/shells/bash/completions/git.bash" ]]; then
  source "$HOME/.config/shells/bash/completions/git.bash"
  complete -o default -o nospace -F _fzf_complete_git cgit
  complete -o default -o nospace -F _fzf_complete_git g
else
  complete -o default -o nospace -F __git_wrap__git_main cgit
  complete -o default -o nospace -F __git_wrap__git_main g
fi
if [[ -r "/usr/share/bash-completion/completions/cargo" ]]; then
  source /usr/share/bash-completion/completions/cargo
  complete -F _cargo c
fi
source_if_exists "$HOME/.config/shells/bash/completions/hg.bash"
source_if_exists "$HOME/.config/shells/bash/completions/docker.bash"
source_if_exists "$HOME/.config/shells/bash/completions/fg.bash"

PS0="\e[2 q" # reset cursor to normal before program runs

export PROMPT_COMMAND=rewrite_history
if command -v zoxide >/dev/null; then
  eval "$(zoxide init bash)"
fi

# starship should go last, otherwise exit status or duration modules might break
if command -v starship >/dev/null; then
  eval "$(starship init bash)"
fi

prune_history
