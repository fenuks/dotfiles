#!/bin/env bash

_fzf_complete_fg() {
  local selected fzf fzf_opt binary cmd_opt
  if [[ -n "${COMP_WORDS[${COMP_CWORD}]}" ]]; then
    return 0
  fi

  fzf="fzf-tmux"
  fzf_opt=(--ansi --height "${FZF_TMUX_HEIGHT:-50%}" --min-height 15 --reverse ${FZF_COMPLETION_OPTS} ${FZF_DEFAULT_OPTS})
  selected=$(jobs | ${fzf} "${fzf_opt[@]}")

  if [[ -v selected ]]; then
    printf '\e[5n'
    if [ -n "${selected}" ]; then
      selected=$(echo "${selected##[}" | grep -Po '^\d+')
      COMPREPLY=("$selected")
      return 0
    fi
  fi
}

[ -n "$BASH" ] && complete -F _fzf_complete_fg -o bashdefault -o nospace fg
