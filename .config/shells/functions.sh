# private
source_if_exists() {
  [[ -r "$1" ]] && source "$1"
}

amdvlkrun() {
  VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/amd_icd32.json:/usr/share/vulkan/icd.d/amd_icd64.json "$@"
}

cmake_pine_gcc() {
  export QEMU_LD_PREFIX=~/Projekty/wbudowane/pinephone/pinephone-rootfs
  export CMAKE_TOOLCHAIN_FILE=~/Projekty/wbudowane/pinephone/gcc_cross.cmake
}

cmake_pine_clang() {
  export QEMU_LD_PREFIX=~/Projekty/wbudowane/pinephone/pinephone-rootfs
  export CMAKE_TOOLCHAIN_FILE=~/Projekty/wbudowane/pinephone/clang_cross.cmake
}

empty_cache() {
  rm -rf "$HOME/.cache/"*
  for dir in "$HOME/Projekty/aur/utrzymywane/"*; do
    if [[ -d "${dir}" ]]; then
      (
        cd "${dir}"
        git clean -xdf
      )
    fi
  done
  sudo rm -rf "$HOME/.local/share/go/pkg/"*
}

rmi() {
  IFS=$'\n'
  files=$(ls -p | grep -v / | fzf -m --ansi --preview='bat --color=always {}')
  if [[ $? -eq 0 ]]; then
    rm ${files}
  fi
}

take() { mkdir -p "$@" && cd "$1"; }

w() {
  # export WINEPREFIX="${XDG_DATA_HOME}/wineprefixes/$1"
  WINEPREFIX="${XDG_DATA_HOME}/wineprefixes/$1" wine "$2"
}
wprefix() {
  export WINEPREFIX="${XDG_DATA_HOME}/wineprefixes/$1"
}

maybe_fg() {
  if [[ $(jobs -p) ]]; then
    fg
  fi
}

runsshagent() {
  ssh-agent -a "${SSH_AUTH_SOCK}"
}

groot() {
  cd "$(git root)"
}

rcd() {
  tempfile="$(mktemp -t tmp.XXXXXX)"
  ranger --choosedir="$tempfile" "${@:-$(pwd)}" --show-only-dirs
  test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n $(pwd))" ]; then
      cd -- "$(cat "$tempfile")"
    fi
  rm -f -- "$tempfile"
}

leafdirs() {
  find . -type d | sort | awk '$0 !~ last "/" {print last} {last=$0} END {print last}'
}

without() {
  file="$1"
  IFS=$'\n'
  for path in $(leafdirs); do
    if [[ ! -f "$path/$file" ]]; then
      echo "$path"
    fi
  done
}

find_up() {
  path=$(pwd)
  match="$1"
  while true; do
    if [[ "${path}" == "" ]]; then
      break
    fi

    if [[ -e "${path}/$1" ]]; then
      match="${path}/$1"
      break
    fi
    path=${path%/*}
  done
  echo "${match}"
}

updmirrorlist() {
  curl -s 'https://archlinux.org/mirrorlist/?country=PL&protocol=https&ip_version=4' | sed 's/^#Server/Server/' | sudo tee /etc/pacman.d/mirrorlist
}

get_terminal_bg() {
  if [ -z "${TERM_BG_BRIGHT}" ]; then
    stty -echo 2>/dev/null
    echo -ne '\e]11;?\a'
    IFS=: read -rt 0.1 -d $'\a' x bg
    stty echo 2>/dev/null
    export TERM_BG_BRIGHT=$((((0x${bg:0:2} * 299 + 0x${bg:6:2} * 587 + 0x${bg:12:2} * 114) / 1000) > 110))
    if [[ "${TERM_BG_BRIGHT}" -eq 1 ]]; then
      export BAT_THEME=OneHalfLight
    else
      export BAT_THEME=ansi-dark
    fi
  fi
}

get_terminal_bg

bak() {
  if [[ ! "$#" -eq 1 ]]; then
    return 1
  fi
  if [[ ! -f "$1" ]]; then
    return 2
  fi
  if [[ "${1:(-4)}" = ".bak" ]]; then
    cp -i "${1::(-4)}"{.bak,}
  else
    cp -i "${1}"{,.bak}
  fi
}

# rewrite last paths, so they use absolute paths
rewrite_history() {
  last="$(history 1 | cut -c 8-)"
  arr=($last)
  if [[ ${arr[0]} == 'vim' || ${arr[0]} == 'nvim' || ${arr[0]} == 'n' || ${arr[0]} == 'v' || ${arr[0]} == 'sudoedit' || ${arr[0]} == 'sh' || ${arr[0]} == 'bash' ]]; then
    newcmd="$(absolute_cmd "${last}")"
    history -d -1
    history -s "$newcmd" # replace command with expanded path
  elif [[ "${last}" =~ 'cd ' ]]; then
    newcmd="cd $(escape_path $(pwd))"
    history -d -1
    history -s "$newcmd" # replace command with expanded path
  fi
}

escape_path() {
  path="$1"
  first_letter="${path:0:1}"
  last_letter="${path:(-1)}"
  if [[ ${first_letter} == "'" || ${last_letter} == '"' ]] && [[ ${first_letter} == ${last_letter} ]]; then
    echo "${path}"
  elif [[ "${path}" == *\'* ]]; then
    if [[ "${path}" == *\"* ]]; then
      printf '%q' "${path}"
    else
      echo "\"${path}\""
    fi
  elif [[ "${path}" == *\"* ]]; then
    echo "'${path}'"
  elif [[ "${path}" == *\* ]]; then
    echo "${path}"
  elif [[ "${path}" =~ ' ' ]]; then
    echo "${path// /\\ }"
  else
    echo "${path}"
  fi

}

absolute_cmd() {
  if [[ "$*" =~ "*" ]]; then
    echo "$*"
    return
  fi
  arr=("$1")
  newcmd=''
  path=""
  for word in ${arr[@]}; do
    first_letter="${word:0:1}"
    last_letter="${word:(-1)}"
    if [[ "${first_letter}" == "'" || "${first_letter}" == '"' ]]; then
      path="${word}"
      if [[ "${last_letter}" == "'" || "${last_letter}" == '"' ]]; then
        if [[ -f "${path:1:-1}" || -d "${path:1:-1}" ]]; then
          path="$(realpath "${path:1:-1}")"
          path="$(escape_path "${path}")"
        else
          path="$(escape_path "${path:1:-1}")"
        fi

        newcmd="${newcmd} ${path}"
        path=''
      fi
    elif [[ "${first_letter}" == '~' ]]; then
      newcmd="${newcmd} ${word}"
    elif [[ "${last_letter}" == "'" || "${last_letter}" == '"' ]]; then
      path="${path} ${word}"
      if [[ -f "${path:1:-1}" || -d "${path:1:-1}" ]]; then
        path="$(realpath "${path:1:-1}")"
        path="$(escape_path "${path}")"
      fi

      newcmd="${newcmd} ${path}"
      path=''
    elif [[ "${last_letter}" != '\' && "${path}" != '' ]]; then
      path="${path} ${word}"
      if [[ -f "${path}" || -d "${path}" ]]; then
        path="$(realpath "${path}")"
        path="$(escape_path "${path}")"
      else
        path="$(escape_path "${path}")"
      fi

      newcmd="${newcmd} ${path}"
      path=''
    elif [[ "${last_letter}" == '\' ]]; then
      if [[ "${path}" == '' ]]; then
        path="${word:0:-1}"
      else
        path="${path} ${word:0:-1}"
      fi
    else
      if [[ ${word:0:2} != './' && ${word:0:1} != '~' && (-f "${word}" || -d "${word}") ]]; then
        word="$(realpath "${word}")"
        word="$(escape_path "${word}")"
      fi

      newcmd="${newcmd} ${word}"
    fi
  done
  echo "${newcmd:1}"
}

# cd that saves absolute path to history (if not starting with space)
acd() {
  if (($# == 0)); then
    builtin cd
  else
    builtin cd "$@"
    return_code=$?
    last="$(history 1 | cut -c 8-)"
    echo "${last} ${return_code}"
    if [[ "${last}" == "cd $*" ]]; then
      if [[ $return_code -eq 0 ]]; then
        msg="cd $(pwd)"
        history -s "$msg" # replace command with expanded path
      else
        history -d -1 # remove last command that failed
      fi
    fi
  fi
}

prune_history() {
  # remove simple commands having less than three words from history
  if [[ ! "${HISTFILE:-}" ]]; then
    echo "ERROR: Unset HISTFILE"
    return
  fi

  # tac "${HISTFILE}" | awk '!x[$0]++' | grep -P '^([^ \\]+(?<!\\) +){2,}.+$' --color=none >| /tmp/history-pruned
  tac "${HISTFILE}" | awk '!x[$0]++' >|/tmp/history-pruned
  tac /tmp/history-pruned >|"${HISTFILE}"
  history -c
  history -r

}

if command -v nvim >/dev/null; then
  function vim() {
    nvim "$@"
  }

  function vimpager() {
    nvim -R "$@"
  }
  export MANPAGER='nvim -i NONE -M -n +Man!'
  export EDITOR=nvim
  [[ -v BASH_VERSION ]] && export -f vim
else
  function vimpager() {
    vim -R "$@"
  }
  export EDITOR=vim
  export MANPAGER="env MAN_PN=1 vim -M +MANPAGER -"
fi

sv() {
  for dir in '.env' 'env' 'venv' '.venv'; do
    match="$(find_up ${dir})"
    if [[ -d "${match}" ]]; then
      source "${match}/bin/activate"
      break
    fi
  done
}

svim() {
  vim -u ~/.config/svim/vimrc "$@"
}

help_vmap() {
  rg '^\s*(v|c|n|i|o|x)?(nnore)?map' ~/.config/nvim/
}

up() {
  UP=$1

  if [[ $UP =~ ^[\-0-9]+$ ]]; then
    if ((UP < 0)); then
      UP=${UP#-}
      cd $(echo "${PWD}" | cut -d/ -f1-$((UP + 1)))
    else
      cd $(printf "%0.s../" $(seq 1 ${UP}))
    fi
  else
    IFS=$'\n' dirs=($(pwd | tr '/' '\n'))
    if [[ "${UP:0:1}" == '-' ]]; then
      UP="${UP:1}"
      cur='/'
      for subdir in ${dirs[@]}; do
        ls ${cur} | grep -P "${UP}" >|/dev/null
        if [[ $? -eq 0 ]]; then
          cd "${cur}"
          break
        fi
        cur="${cur}/${subdir}"
      done
    else
      cur='.'
      for i in $(seq ${#dirs[@]}); do
        cur=$(realpath "${cur}/..")
        if [[ "${cur}" =~ "${UP}" ]]; then
          cd "${cur}"
          break
        fi

        ls ${cur} | grep -P "${UP}" >|/dev/null
        if [[ $? -eq 0 ]]; then
          cd "${cur}"
          break
        fi
      done
    fi
  fi
}

# export functions in bash
if [[ -v BASH_VERSION ]]; then
  export -f vimpager
  export -f sv
  export -f svim
fi

# function for git-fzf completions
is_in_git_repo() {
  git rev-parse HEAD >/dev/null 2>&1
}

if [[ "${TERM_BG_BRIGHT}" -eq 1 ]]; then
  fzf_colour=light
else
  fzf_colour=dark
fi

fzf_down() {
  fzf --color=${fzf_colour} --height 50% "$@"
}

gf() {
  is_in_git_repo || return
  git ls-files | fzf_down --ansi -m --preview 'cat {-1} | head -500'
}

gs() {
  is_in_git_repo || return
  git -c color.status=always status --short |
    fzf_down -m --ansi --nth 2..,.. \
      --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
    cut -c4- | sed 's/.* -> //'
}

gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
    fzf_down --ansi --multi --tac --preview-window right:70% \
      --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
    sed 's/^..//' | cut -d' ' -f1 |
    sed 's#^remotes/##'
}

gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
    fzf_down --multi --preview-window right:70% \
      --preview 'git show --color=always {} | head -'$LINES
}

gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
    fzf_down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
      --header 'Press CTRL-S to toggle sort' \
      --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
    grep -o "[a-f0-9]\{7,\}"
}

gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
    fzf_down --tac \
      --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
    cut -d$'\t' -f1
}
