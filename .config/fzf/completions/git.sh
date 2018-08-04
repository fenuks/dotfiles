#!/bin/env bash

_fzf_complete_git() {

    local selected fzf fzf_opt binary cmd_opt
    if [[ -n "${COMP_WORDS[${COMP_CWORD}]}" ]]; then
        _git "${@}"
        return 0
    fi

    binary="${COMP_WORDS[0]}"
    cmd_opt="${COMP_WORDS[*]:1}"
    cmd_last_opt="${COMP_WORDS[${COMP_CWORD}-1]}"
    fzf="$(__fzfcmd_complete)"
    fzf_opt=(--height "${FZF_TMUX_HEIGHT:-50%}" --min-height 15 --reverse --preview 'echo {}' --preview-window down:3:wrap ${FZF_COMPLETION_OPTS} ${FZF_DEFAULT_OPTS})

    if [[ "${cmd_opt}" == 'add '* ]]; then
        selected=$( ( ${binary} status --short | grep -v -P '^(A|R|D|M) ' ) | ${fzf} "${fzf_opt[@]}" -m | awk '{$1=""; print substr($0,2)}' | tr '\n' ' ')
    elif [[ "${cmd_opt}" == 'reset '* ]]; then
        selected=$( ( ${binary} status --short | grep -P '^(A|R|D|M)' ) | ${fzf} "${fzf_opt[@]}" -m | awk '{$1=""; print substr($0,2)}' | tr '\n' ' ')
    elif [[ "${cmd_opt}" == 'diff '* ]]; then
        selected=$( ( ${binary} status --short ) | ${fzf} "${fzf_opt[@]}" -m | awk '{$1=""; print substr($0,2)}' | tr '\n' ' ')
    fi

    if [[ -v selected ]]; then
        printf '\e[5n'
        if [ -n "${selected}" ]; then
            COMPREPLY=( "$selected" )
            return 0
        fi
    fi
    _git "${@}"
}

[ -n "$BASH" ] && complete -F _fzf_complete_git -o default -o bashdefault -o nospace git
