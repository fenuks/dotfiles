#!/bin/env bash

_fzf_complete_hg() {
    local selected fzf fzf_opt hg hg_opt
    if [[ -n "${COMP_WORDS[${COMP_CWORD}]}" ]]; then
        _hg "${@}"
        return 0
    fi

    hg="${COMP_WORDS[0]}"
    hg_opt="${COMP_WORDS[*]:1}"
    hg_last_opt="${COMP_WORDS[${COMP_CWORD}-1]}"
    fzf="$(__fzfcmd_complete)"
    fzf_opt="--height ${FZF_TMUX_HEIGHT:-50%} --min-height 15 --reverse ${FZF_DEFAULT_OPTS} --preview 'echo {}' --preview-window down:3:wrap ${FZF_COMPLETION_OPTS}"

    if [[ "${hg_last_opt}" == '-b' ]] || [[ "${hg_last_opt}" == '--branch' ]]; then
            selected=$( ( ${hg} branches ) | FZF_DEFAULT_OPTS=${fzf_opt} ${fzf} | awk '{print $1}' | tr '\n' ' ')
    elif [[ "${hg_opt}" == 'merge '* ]] || [[ "${hg_opt}" == 'up '* ]] \
        || [[ "${hg_opt}" == 'update '* ]] || [[ "${hg_opt}" == 'co '* ]] \
        || [[ "${hg_opt}" == 'checkout '* ]];
    then
        if [[ "${hg_last_opt}" == '-r' ]]; then
            # TODO: support for revisions
            _hg "$@"
            return 0
        else
            selected=$( ( ${hg} branches & ${hg} tags ) | FZF_DEFAULT_OPTS=${fzf_opt} ${fzf} | awk '{print $1}' | tr '\n' ' ')
        fi
    elif [[ "${hg_opt}" == 'add '* ]]; then
        selected=$( ( ${hg} status --unknown ) | FZF_DEFAULT_OPTS=${fzf_opt} ${fzf} -m | awk '{print $2}' | tr '\n' ' ')
    elif [[ "${hg_opt}" == 'annotate '* ]]; then
        selected=$( ( ${hg} files ) | FZF_DEFAULT_OPTS=${fzf_opt} ${fzf} -m | tr '\n' ' ')
    elif [[ "${hg_opt}" == 'diff '* ]]; then
        selected=$( ( ${hg} status -mard ) | FZF_DEFAULT_OPTS=${fzf_opt} ${fzf} -m | awk '{print $2}' | tr '\n' ' ')
    elif [[ "${hg_opt}" == 'forget '* ]]; then
        selected=$( ( ${hg} status -a ) | FZF_DEFAULT_OPTS=${fzf_opt} ${fzf} -m | awk '{print $2}' | tr '\n' ' ')
    elif [[ "${hg_opt}" == 'push '* ]]; then
        if [[ "${hg_last_opt}" == '-r' ]]; then
            # TODO: support for revisions -r
            _hg "$@"
            return 0
        elif [[ "${hg_last_opt}" == '-B' ]] || [[ "${hg_last_opt}" == '--bookmark' ]]; then
            # TODO: support for bookmarks
            _hg "$@"
            return 0
        fi
    elif [[ "${hg_opt}" == 'revert '* ]]; then
        selected=$( ( ${hg} status -mard ) | FZF_DEFAULT_OPTS=${fzf_opt} ${fzf} -m | awk '{print $2}' | tr '\n' ' ')
    elif [[ "${hg_opt}" == 'rm '* ]] || [[ "${hg_opt}" == 'remove '* ]]; then
        selected=$( ( ${hg} files ) | FZF_DEFAULT_OPTS=${fzf_opt} ${fzf} -m | tr '\n' ' ')
    elif [[ "${hg_opt}" == 'shelve '* ]]; then
        if [[ "${hg_last_opt}" == '-d' ]] || [[ "${hg_last_opt}" == '--delete' ]] || [[ "${hg_last_opt}" == '-p' ]] || [[ "${hg_last_opt}" == '--patch' ]]; then
            selected=$( ( ${hg} shelve --list --quiet ) | FZF_DEFAULT_OPTS=${fzf_opt} ${fzf} -m | awk '{print $1}' | tr '\n' ' ')
        else
            selected=$( ( ${hg} status -ma ) | FZF_DEFAULT_OPTS=${fzf_opt} ${fzf} -m | awk '{print $2}' | tr '\n' ' ')
        fi
    elif [[ "${hg_opt}" == 'unshelve '* ]]; then
        if [[ "${hg_last_opt}" == '-n' ]] || [[ "${hg_last_opt}" == '--name' ]] || [[ "${hg_last_opt}" == "unshelve" ]]; then
            selected=$( ( ${hg} shelve --list --quiet ) | FZF_DEFAULT_OPTS=${fzf_opt} ${fzf} -m | awk '{print $1}' | tr '\n' ' ')
        fi
    fi

    if [[ -v selected ]]; then
        printf '\e[5n'
        if [ -n "${selected}" ]; then
            COMPREPLY=( "$selected" )
            return 0
        fi
    fi
    _hg "$@"
}

[ -n "$BASH" ] && complete -F _fzf_complete_hg -o default -o bashdefault -o nospace hg
