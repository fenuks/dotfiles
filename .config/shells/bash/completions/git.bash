#!/bin/env bash

_fzf_complete_git() {
  local selected fzf fzf_opt binary cmd_opt
  if [[ -n "${COMP_WORDS[${COMP_CWORD}]}" ]]; then
    __git_wrap__git_main "${@}"
    return 0
  fi

  binary="${COMP_WORDS[0]}"
  if [[ $binary == 'g' ]]; then
    binary='git'
  fi
  relative_paths=$(${binary} config status.relativePaths)
  prefix=""
  if [[ ${relative_paths:-true} == false ]]; then
    prefix="$(${binary} rev-parse --show-toplevel)/"
  fi
  cmd_opt="${COMP_WORDS[*]:1}"
  cmd_last_opt="${COMP_WORDS[${COMP_CWORD} - 1]}"
  fzf="fzf"
  fzf_opt=(--ansi --height "${FZF_TMUX_HEIGHT:-50%}" --min-height 15 --reverse ${FZF_COMPLETION_OPTS} ${FZF_DEFAULT_OPTS})

  add_preview="
    git_file={}
    git_prefix=\${git_file:0:2}
    file=\${git_file:3}
    if [[ \${file:0:1} == '\"' ]]; then
        file=\${file:1:-1}
    fi
    file=\$(echo \${file} | sed -E -e 's/^[^>]+ -> //')
    file=\"${prefix}\${file}\"
    if [[ \${git_prefix} == \"??\" ]]; then
        if [[ -f \${file} ]]; then
            cat \${file}
        else
            ls \${file} --color=always
        fi
    elif [[ \${git_prefix} == ' D' ]]; then
        ${binary} show \"HEAD^:\${file}\"
    else
        ${binary} diff --color=always \"\${file}\" | ${GIT_PAGER:-less}
    fi
    "

  file_preview="
    file={}
    if [[ \${file:0:1} == '\"' ]]; then
        file=\${file:1:-1}
    fi
    file=\"${prefix}\${file}\"
    bat --color=always \${file} | head -$LINES
    # echo \"\${file}\"
    "

  diff_preview="
        git_file={}
        git_prefix=\${git_file:0:2}
        file=\${git_file:3}
        if [[ \${file:0:1} == '\"' ]]; then
            file=\${file:1:-1}
        fi
        file=\"${prefix}\${file}\"
        echo \"\${file}\" | xargs -I '%' ${binary} diff --color=always %
    "

  staged_preview="
        git_file={}
        git_prefix=\${git_file:0:2}
        file=\${git_file:3}
        if [[ \${file:0:1} == '\"' ]]; then
            file=\${file:1:-1}
        fi
        file=\"${prefix}\${file}\"
        echo \"\${file}\" | xargs -I '%' ${binary} diff --staged --color=always %
    "

  if [[ "${cmd_opt}" == 'add '* ]]; then
    selected=$( (${binary} status --short | grep -vP '^(A|R|D|M) ') | ${fzf} "${fzf_opt[@]}" -m --preview-window=right,75% --preview "${add_preview}" | awk '{$1=""; print substr($0,2)}' | sed -E -e "s|^|${prefix}|" -e 's/^[^>]+ -> //' | tr '\n' ' ')
  elif [[ "${cmd_opt}" == 'checkout '* ]] || [[ "${cmd_opt}" == 'co '* ]]; then
    if [[ "${cmd_last_opt}" == "-b" ]] || [[ "${cmd_last_opt}" == "--branch" ]]; then
      selected=$(${binary} branch --remotes | sed 1d | awk '{ print $1 }' | ${fzf} "${fzf_opt[@]}" -m | tr '\n' ' ')
    else
      selected=$( (${binary} status --short | grep -v -P '^(A|R|D|M|U|\?\?) ') | ${fzf} "${fzf_opt[@]}" -m --preview "${diff_preview}" | awk '{$1=""; print substr($0,2)}' | sed -E -e "s|^|${prefix}|" | tr '\n' ' ')
    fi
  elif [[ "${cmd_opt}" == 'diff '* ]]; then
    selected=$( (${binary} status --short) | ${fzf} "${fzf_opt[@]}" -m --preview "${diff_preview}" | awk '{$1=""; print substr($0,2)}' | sed "s|^|${prefix}|" | tr '\n' ' ')
  elif [[ "${cmd_opt}" == 'reset '* ]]; then
    selected=$( (${binary} status --short | grep -P '^(A|R|D|M|U)') | ${fzf} "${fzf_opt[@]}" -m --preview "${staged_preview}" | awk '{$1=""; print substr($0,2)}' | sed "s|^|${prefix}|" | tr '\n' ' ')
  elif [[ "${cmd_opt}" == 'stash push '* ]]; then
    selected=$( (${binary} status --short | grep -v -P '^\?') | ${fzf} "${fzf_opt[@]}" -m --preview "${diff_preview}" | awk '{$1=""; print substr($0,2)}' | sed "s|^|${prefix}|" | tr '\n' ' ')
  elif [[ "${cmd_opt}" == 'mr '* ]]; then
    selected=$( (ls $(${binary} root)/.git/refs/remotes/origin/merge-requests/ | ${fzf} "${fzf_opt[@]}" -m --preview "${binary} show --color=always --shortstat origin/merge-requests/{}head" | tr '\n' ' '))
  elif [[ "${cmd_opt}" == 'rm '* ]]; then
    selected=$( (${binary} ls-files | ${fzf} "${fzf_opt[@]}" -m --preview-window=right,75% --preview "${file_preview}" | awk '{$1=""; print substr($0,2)}' | sed "s|^|${prefix}|" | tr '\n' ' '))
  fi

  if [[ -v selected ]]; then
    # To redraw line after fzf closes (printf '\e[5n')
    bind '"\e[0n": redraw-current-line'
    printf '\e[5n'
    if [ -n "${selected}" ]; then
      COMPREPLY=("$selected")
      return 0
    fi
  fi
  __git_wrap__git_main "${@}"
}

[ -n "$BASH" ] && complete -F _fzf_complete_git -o default -o nospace git
