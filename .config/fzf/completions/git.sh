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
    fzf_opt=(--height "${FZF_TMUX_HEIGHT:-50%}" --min-height 15 --reverse ${FZF_COMPLETION_OPTS} ${FZF_DEFAULT_OPTS})
    preview_command="
    git_file={}
    file=\${git_file:3}
    git_prefix=\${git_file:0:2}
    if [[ \${file:0:1} == '\"' ]]; then
        file=\${file:1:-1}
    fi
    if [[ \${git_prefix} == \"??\" ]]; then
        if [[ -f \${file} ]]; then
            cat \${file} | head -$LINES
        else
            ls \${file} --color=always | head -$LINES
        fi
    elif [[ \${git_prefix} == ' D' ]]; then
        ${binary} show \"HEAD^:\${file}\" | head -$LINES
    else
        ${binary} diff --color=always \"\${file}\" | head -$LINES
    fi
    "

    if [[ "${cmd_opt}" == 'add '* ]]; then
        selected=$( ( ${binary} status --short | grep -vP '^(A|R|D|M) ' ) | ${fzf} "${fzf_opt[@]}" -m --preview "${preview_command}" | awk '{$1=""; print substr($0,2)}' | tr '\n' ' ')
    elif [[ "${cmd_opt}" == 'checkout '* ]]; then
        if [[ "${cmd_last_opt}" == "-b" ]] || [[ "${cmd_last_opt}" == "--branch" ]]; then
            selected=$( ${binary} branch --remotes | sed 1d | awk '{ print $1 }' | ${fzf} "${fzf_opt[@]}" -m |  tr '\n' ' ')
        else
            selected=$( ( ${binary} status --short | grep -v -P '^(A|R|D|M|U|\?\?) ' ) | ${fzf} "${fzf_opt[@]}" -m --preview "echo {} | cut -c 3- | xargs -I '%' ${binary} diff --color=always % | head -$LINES" | awk '{$1=""; print substr($0,2)}' | tr '\n' ' ')
        fi
    elif [[ "${cmd_opt}" == 'diff '* ]]; then
        selected=$( ( ${binary} status --short ) | ${fzf} "${fzf_opt[@]}" -m --preview "echo {} | cut -c 3- | xargs -I '%' ${binary} diff --color=always % | head -$LINES" | awk '{$1=""; print substr($0,2)}' | tr '\n' ' ')
    elif [[ "${cmd_opt}" == 'reset '* ]]; then
        selected=$( ( ${binary} status --short | grep -P '^(A|R|D|M|U)' ) | ${fzf} "${fzf_opt[@]}" -m --preview "echo {} | cut -c 3- | xargs -I '%' ${binary} diff --staged --color=always % | head -$LINES" | awk '{$1=""; print substr($0,2)}' | tr '\n' ' ')
    elif [[ "${cmd_opt}" == 'stash push '* ]]; then
        selected=$( ( ${binary} status --short | grep -v -P '^(A|R|D|M) ' ) | ${fzf} "${fzf_opt[@]}" -m --preview "echo {} | cut -c 3- | xargs -I '%' ${binary} diff --color=always % | head -$LINES" | awk '{$1=""; print substr($0,2)}' | tr '\n' ' ')
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
