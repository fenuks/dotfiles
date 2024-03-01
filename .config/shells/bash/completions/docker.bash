#!/bin/env bash

_fzf_complete_docker() {
  local selected fzf fzf_opt binary cmd_opt
  if [[ -n "${COMP_WORDS[${COMP_CWORD}]}" ]]; then
    __start_docker "${@}"
    return 0
  fi

  binary="${COMP_WORDS[0]}"
  cmd_opt="${COMP_WORDS[*]:1}"
  cmd_last_opt="${COMP_WORDS[${COMP_CWORD} - 1]}"
  fzf="fzf-tmux"
  fzf_opt=(--height "${FZF_TMUX_HEIGHT:-50%}" --min-height 15 --reverse --preview 'echo {}' --preview-window down:3:wrap ${FZF_COMPLETION_OPTS} ${FZF_DEFAULT_OPTS})

  if [[ "${cmd_opt}" == 'attach '* ]]; then
    selected=$("${binary}" ps | sed '1d' | ${fzf} "${fzf_opt[@]}" +m | awk -F '\\s{2,}' '{ print $7 }' | tr '\n' ' ')
  elif [[ "${cmd_opt}" == 'build '* ]]; then
    if [[ "${cmd_last_opt}" == '-t' ]] || [[ "${cmd_last_opt}" == '--tag' ]]; then
      selected=$(__fzf_docker_images "${binary}" | ${fzf} "${fzf_opt[@]}" -m | awk '{print $1}' | tr '\n' ' ')
    fi
  elif [[ "${cmd_opt}" == 'exec '* ]]; then
    selected=$("${binary}" ps | sed '1d' | ${fzf} "${fzf_opt[@]}" +m | awk -F '\\s{2,}' '{ print "-it "$1" bash" }' | tr '\n' ' ')
  elif [[ "${cmd_opt}" == 'cp '* ]]; then
    selected=$("${binary}" ps | sed '1d' | ${fzf} "${fzf_opt[@]}" +m | awk -F '\\s{2,}' '{ print ""$1":/" }' | tr '\n' ' ')
  elif [[ "${cmd_opt}" == 'inspect '* ]]; then
    selected=$("${binary}" images | sed '1d' | ${fzf} "${fzf_opt[@]}" -m | awk '{print $1":"$2}' | tr '\n' ' ')
  elif [[ "${cmd_opt}" == 'kill '* ]] || [[ "${cmd_opt}" == 'stop '* ]]; then
    selected=$("${binary}" ps | sed '1d' | ${fzf} "${fzf_opt[@]}" -m | awk -F '\\s{2,}' '{ print $7 }' | tr '\n' ' ')
  elif [[ "${cmd_opt}" == 'save '* ]]; then
    selected=$(__fzf_docker_images "${binary}" | ${fzf} "${fzf_opt[@]}" +m | awk '{match($1, /[^/]+$/, m1); print $1":"$2" -o "m1[0]"_"$2}' | tr '\n' ' ')
  elif [[ "${cmd_opt}" == 'pull '* ]]; then
    selected=$(__fzf_docker_images "${binary}" | awk '{print $1}' | sort | uniq | ${fzf} "${fzf_opt[@]}" -m | tr '\n' ' ')
  elif [[ "${cmd_opt}" == 'push '* ]]; then
    selected=$("${binary}" images | sed '1d' | ${fzf} "${fzf_opt[@]}" -m | awk '{print $1":"$2}' | tr '\n' ' ')
  elif [[ "${cmd_opt}" == 'run '* ]]; then
    selected=$("${binary}" images | sed '1d' | ${fzf} "${fzf_opt[@]}" -m | awk '{print "-it --rm -v/var/run/docker.sock:/var/run/docker.sock -v$PWD:/src --workdir /src "$1":"$2" bash"}' | tr '\n' ' ')
  elif [[ "${cmd_opt}" == 'start '* ]]; then
    selected=$("${binary}" images | sed '1d' | ${fzf} "${fzf_opt[@]}" -m | awk '{print ""$1":"$2""}' | tr '\n' ' ')
  elif [[ "${cmd_opt}" == 'rmi '* ]]; then
    selected=$("${binary}" images | sed '1d' | ${fzf} "${fzf_opt[@]}" -m | awk '{print $3}' | tr '\n' ' ')
  elif [[ "${cmd_opt}" == 'rm '* ]]; then
    selected=$("${binary}" ps -a | sed '1d' | ${fzf} "${fzf_opt[@]}" -m | awk '{print $1}' | tr '\n' ' ')
  elif [[ "${cmd_opt}" == 'tag '* ]]; then
    selected=$("${binary}" images | sed '1d' | ${fzf} "${fzf_opt[@]}" -m | awk '{print $1":"$2}' | tr '\n' ' ')
  fi

  if [[ -v selected ]]; then
    printf '\e[5n'
    if [ -n "${selected}" ]; then
      COMPREPLY=("$selected")
      return 0
    fi
  fi
  __start_docker "${@}"
}

__fzf_docker_images() {
  $1 images | sed '1d' | grep -v '<none>'
}

[ -n "$BASH" ] && complete -F _fzf_complete_docker -o default -o nospace docker
