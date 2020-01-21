if command -v fd > /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f'
    export FZF_ALT_C_COMMAND='fd --type d'
elif command -v rg > /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files 2> /dev/null'
elif command -v ag > /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -g "" 2> /dev/null'
fi
export SKIM_DEFAULT_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline
