#!/bin/env bash

_fzf_complete_git() {
  local selected fzf fzf_opt binary cmd_opt
  if [[ -n "${COMP_WORDS[${COMP_CWORD}]}" ]]; then
    __git_wrap__git_main "${@}"
    return 0
  fi

  binary="${COMP_WORDS[0]}"
  relative_paths=$(${binary} config status.relativePaths)
  repo_root=$(${binary} rev-parse --show-toplevel)
  cmd_opt="${COMP_WORDS[*]:1}"
  cmd_last_opt="${COMP_WORDS[${COMP_CWORD} - 1]}"
  fzf="fzf-tmux"
  fzf_opt=(--ansi --height "${FZF_TMUX_HEIGHT:-50%}" --min-height 15 --reverse ${FZF_COMPLETION_OPTS} ${FZF_DEFAULT_OPTS})

  add_preview="
    git_file={}
    git_prefix=\${git_file:0:2}
    file=\${git_file:3}
    if [[ \${file:0:1} == '\"' ]]; then
        file=\${file:1:-1}
    fi
    if [[ ${relative_paths:-true} == false ]]; then
        file=\"${repo_root}/\${file}\"
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
    echo \"\${file}\"
    "

  diff_preview="
        git_file={}
        git_prefix=\${git_file:0:2}
        file=\${git_file:3}
        if [[ \${file:0:1} == '\"' ]]; then
            file=\${file:1:-1}
        fi
        if [[ ${relative_paths:-true} == false ]]; then
            file=\"${repo_root}/\${file}\"
        fi
        echo \"\${file}\" | xargs -I '%' ${binary} diff --color=always %
    "

  staged_preview="
        git_file={}
        git_prefix=\${git_file:0:2}
        file=\${git_file:3}
        if [[ \${file:0:1} == '\"' ]]; then
            file=\${file:1:-1}
        fi
        if [[ ${relative_paths:-true} == false ]]; then
            file=\"${repo_root}/\${file}\"
        fi
        echo \"\${file}\" | xargs -I '%' ${binary} diff --staged --color=always %
    "

  if [[ "${cmd_opt}" == 'add '* ]]; then
    selected=$( (${binary} status --short | grep -vP '^(A|R|D|M) ') | ${fzf} "${fzf_opt[@]}" -m --preview-window=right,75% --preview "${add_preview}" | awk '{$1=""; print substr($0,2)}' | tr '\n' ' ')
  elif [[ "${cmd_opt}" == 'checkout '* ]]; then
    if [[ "${cmd_last_opt}" == "-b" ]] || [[ "${cmd_last_opt}" == "--branch" ]]; then
      selected=$(${binary} branch --remotes | sed 1d | awk '{ print $1 }' | ${fzf} "${fzf_opt[@]}" -m | tr '\n' ' ')
    else
      selected=$( (${binary} status --short | grep -v -P '^(A|R|D|M|U|\?\?) ') | ${fzf} "${fzf_opt[@]}" -m --preview "${diff_preview}" | awk '{$1=""; print substr($0,2)}' | tr '\n' ' ')
    fi
  elif [[ "${cmd_opt}" == 'diff '* ]]; then
    selected=$( (${binary} status --short) | ${fzf} "${fzf_opt[@]}" -m --preview "${diff_preview}" | awk '{$1=""; print substr($0,2)}' | tr '\n' ' ')
  elif [[ "${cmd_opt}" == 'reset '* ]]; then
    selected=$( (${binary} status --short | grep -P '^(A|R|D|M|U)') | ${fzf} "${fzf_opt[@]}" -m --preview "${staged_preview}" | awk '{$1=""; print substr($0,2)}' | tr '\n' ' ')
  elif [[ "${cmd_opt}" == 'stash push '* ]]; then
    selected=$( (${binary} status --short | grep -v -P '^(A|R|D|M) ') | ${fzf} "${fzf_opt[@]}" -m --preview "${diff_preview}" | awk '{$1=""; print substr($0,2)}' | tr '\n' ' ')
  fi

  if [[ -v selected ]]; then
    printf '\e[5n'
    if [ -n "${selected}" ]; then
      COMPREPLY=("$selected")
      return 0
    fi
  fi
  __git_wrap__git_main "${@}"
}

[ -n "$BASH" ] && complete -F _fzf_complete_git -o default -o nospace git
