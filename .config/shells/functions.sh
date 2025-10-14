_cg_complete() {
  local git_root="$(git rev-parse --show-toplevel 2>/dev/null)"
  if [[ "${git_root}" == "" ]]; then
    return
  fi

  local file
  for file in "${git_root}/$2"*; do
    [[ -d $file ]] || continue

    local relative="${file#$git_root/}/"
    COMPREPLY+=("${relative}")
  done
}

mdfmt() {
  mkdir -p ~/.cache/deno
  deno fmt --config ~/.config/deno/deno.jsonc ${@}
  # remove useless empty lines after header
  sed -i '/^#/{n;/^$/d;}' ${@}
}

_up_complete() {
  if [[ "${COMP_CWORD}" -ne 2 ]]; then
    return
  fi
  path="$(up_path "${COMP_WORDS[1]}")"
  if [[ -z "${path}" ]]; then
    return
  fi
  IFS=$'\n'
  for candidate in $(compgen -d "${path}${COMP_WORDS[2]}"); do
    COMPREPLY+=("$(escape_path "$(realpath --relative-to="${path}" "${candidate}")")")
  done
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

acd() {
  # cd that saves absolute path to history (if not starting with space)
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

aglob() {
  printf "%s\n" ${2:-*} | sed -n "/$1/,\$p"
}

amdvlkrun() {
  VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/amd_icd32.json:/usr/share/vulkan/icd.d/amd_icd64.json "$@"
}

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

c() {
  local dir
  dir=$(
    FZF_DEFAULT_COMMAND=${FZF_ALT_C_COMMAND:-} \
      FZF_DEFAULT_OPTS=$(__fzf_defaults "--reverse --walker=dir,follow,hidden --scheme=path" "${FZF_ALT_C_OPTS-} +m") \
      FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd)
  ) && builtin cd -- "$(builtin unset CDPATH && builtin cd -- "$dir" && builtin pwd)"
}

cg() {
  local git_root="$(git rev-parse --show-toplevel)"
  if [[ -n "${git_root}" ]]; then
    cd "${git_root}/$1"
  fi
}

cmake_pine_clang() {
  export QEMU_LD_PREFIX=~/Projekty/wbudowane/pinephone/pinephone-rootfs
  export CMAKE_TOOLCHAIN_FILE=~/Projekty/wbudowane/pinephone/clang_cross.cmake
}

cmake_pine_gcc() {
  export QEMU_LD_PREFIX=~/Projekty/wbudowane/pinephone/pinephone-rootfs
  export CMAKE_TOOLCHAIN_FILE=~/Projekty/wbudowane/pinephone/gcc_cross.cmake
}

cpr() {
  rsync --archive --human-readable --partial --info=stats3,progress2 "$@"
}

empty_cache() {
  rm -rf "$HOME/.cache/"*
  rm -rf ~/.gradle
  for dir in "$HOME/Kod/otwarty/system/arch/aur/budowane/"*; do
    if [[ -d "${dir}" ]]; then
      (
        cd "${dir}"
        git clean -xdf
      )
    fi
  done
  sudo rm -rf "$HOME/.local/share/go/pkg/"*
  sudo pacman -Scc
  sudo systemctl start docker
  docker system prune --force
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

fzf_dir() {
  eval $FZF_ALT_C_COMMAND | fzf_down --ansi --preview 'ls {} | head -500'
}

fzf_down() {
  fzf --color=${fzf_colour} --height 50% "$@"
}

gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
    fzf_down --ansi --multi --tac --preview-window right:70% \
      --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
    sed 's/^..//' | cut -d' ' -f1 |
    sed 's#^remotes/##'
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
      export BAT_THEME=ansi
    fi
  fi
}

gf() {
  is_in_git_repo || return
  git ls-files | fzf_down --ansi -m --preview 'cat {-1} | head -500'
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

gs() {
  is_in_git_repo || return
  git -c color.status=always status --short |
    fzf_down -m --ansi --nth 2..,.. \
      --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
    cut -c4- | sed 's/.* -> //'
}

gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
    fzf_down --multi --preview-window right:70% \
      --preview 'git show --color=always {} | head -'$LINES
}

help_vmap() {
  rg '^\s*(v|c|n|i|o|x)?(nnore)?map' ~/.config/nvim/
}

is_in_git_repo() {
  # function for git-fzf completions
  git rev-parse HEAD >/dev/null 2>&1
}

leafdirs() {
  find . -type d | sort | awk '$0 !~ last "/" {print last} {last=$0} END {print last}'
}

maybe_fg() {
  if [[ $(jobs -p) ]]; then
    fg
  fi
}

mvr() {
  rsync --archive --human-readable --partial --info=stats3,progress2 --remove-source-files "$@"
}

pacverify() {
  sudo paccheck --file-properties --quiet --require-mtree | grep -E -v '(modification time|symlink target|size) mismatch'
  VISUAL='nvim -d' DIFFPROG=sudoedit pacdiff
  sudo pacman -Rss $(pacman -Qdtq)
}

prune_history() {
  # remove simple commands having less than three words from history
  if [[ ! "${HISTFILE:-}" ]]; then
    echo "ERROR: Unset HISTFILE"
    return
  fi

  tac "${HISTFILE}" | awk '!x[$0]++' | tac >|"${HISTFILE}.bak"
  cp "${HISTFILE}.bak" "${HISTFILE}"
  history -c
  history -r

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

try() {
  runs=0
  max_runs=10
  declare -a durations=()
  while true; do
    runs=$((runs + 1))
    echo "Rozpoczęcie wykonania nr ${runs}"
    SECONDS=0
    "$@"
    exit_code="$?"
    if [[ "${exit_code}" -ne 0 ]]; then
      sorted_durations=($(printf '%s\n' "${durations[@]}" | sort))
      printf 'Błąd nastąpił w wywołaniu nr %s po %s z kodem %s\n' "${runs}" "$(date -u -d @${SECONDS} +'%T')" "${exit_code}"
      printf 'Czasy wykonania w sekundach: '
      printf '%s\n' "${sorted_durations[@]}" | xargs -I# date -u -d @# +%T
      break
    fi
    durations+=("${SECONDS}")
    if [[ "${runs}" -ge "${max_runs}" ]]; then
      sorted_durations=($(printf '%s\n' "${durations[@]}" | sort -n))
      printf 'Komenda nie zwróciła błędu po %s wykonaniach.\n' "${runs}"
      printf 'Czasy wykonania w sekundach: '
      printf '%s\n' "${sorted_durations[@]}" | xargs -I# date -u -d @# +%T
      break
    fi
  done
}

rewrite_history() {
  # rewrite last paths, so they use absolute paths
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

rmbak() {
  shopt -s nullglob
  files=(*.bak)
  if [[ "${#files[@]}" -eq 0 ]]; then
    return 0
  fi
  read -n 1 -p "Remove ${files[@]}? [Y/n] " resp
  if [[ "$resp" == $'\n' ]]; then
    rm -f *.bak
  elif [[ "$resp" == "y" || "$resp" == "Y" || "$resp" == "t" || "$resp" == "T" ]]; then
    echo
    rm -f *.bak
  else
    echo
  fi
}

take() { mkdir -p "$@" && cd "$1"; }

rmf() {
  echo -e "Usunąć? [YT/n]:\n$@"
  read -n 1
  echo
  if [[ $REPLY =~ ^[YyTt]$ ]]; then
    rm -f $@
  fi
}

rmi() {
  IFS=$'\n'
  files=$(ls -p | grep -v / | fzf -m --ansi --preview='bat --color=always {}')
  if [[ $? -eq 0 ]]; then
    rm ${files}
  fi
}

runsshagent() {
  ssh-agent -a "${SSH_AUTH_SOCK}"
}

source_if_exists() {
  [[ -r "$1" ]] && source "$1"
}

sv() {
  for dir in '.venv-dev' '.venv' '.env' 'env' 'venv'; do
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

up() {
  UP=$1
  new_dir="$(up_path "$1")"
  if [[ -n "${new_dir}" ]]; then
    cd "${new_dir}/${2}"
  fi
}

up_path() {
  UP=$1

  # if provided positive or neganive number
  if [[ $UP =~ ^[\-0-9]+$ ]]; then
    if ((UP < 0)); then
      UP=${UP#-}
      echo "${PWD}" | cut -d/ -f1-$((UP + 1))
    else
      printf "%0.s../" $(seq 1 ${UP})
    fi
  # if provided word that can be negative
  else
    IFS=$'\n' dirs=($(pwd | tr '/' '\n'))
    if [[ "${UP:0:1}" == '-' ]]; then
      UP="${UP:1}"
      cur='/'
      for subdir in ${dirs[@]}; do
        ls ${cur} | grep -P "${UP}" >|/dev/null
        if [[ $? -eq 0 ]]; then
          echo "${cur}/"
          break
        fi
        cur="${cur}/${subdir}/"
      done
    else
      UP="${UP,,}"
      cur='.'
      for i in $(seq ${#dirs[@]}); do
        cur=$(realpath "${cur}/..")
        dirname="$(basename ${cur})"
        dirname="${dirname,,}"
        if [[ "${dirname}" =~ "${UP}" ]]; then
          echo "${cur}/"
          break
        fi
      done
    fi
  fi
}

updmirrorlist() {
  curl -s 'https://archlinux.org/mirrorlist/?country=PL&protocol=https&ip_version=4' | sed 's/^#Server/Server/' | sudo tee /etc/pacman.d/mirrorlist
}

vk() {
  vim "${XDG_DOCUMENTS_DIR}/notatki/kalendarz/roczne/$(date +%Y).rem"
}

vn() {
  (
    cd "${XDG_DOCUMENTS_DIR}/notatki"
    nvim brudnopis/aktualne.md
  )
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

wprefix() {
  export WINEPREFIX="${XDG_DATA_HOME}/wineprefixes/$1"
}

pac-installed() {
  pacman -Qq | fzf --preview 'pacman -Qil {}'
  --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
}

rfv() (
  # https://junegunn.github.io/fzf/tips/ripgrep-integration/
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            vim {1} +{2}
          else
            vim +cw -q {+f}
          fi'
  fzf --disabled --ansi --multi \
    --bind "start:$RELOAD" --bind "change:$RELOAD" \
    --bind "enter:become:$OPENER" \
    --bind "ctrl-o:execute:$OPENER" \
    --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
    --delimiter : \
    --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
    --preview-window '~4,+{2}+4/3,<80(up)' \
    --query "$*"
)

get_terminal_bg

if [[ "${TERM_BG_BRIGHT}" -eq 1 ]]; then
  fzf_colour=light
else
  fzf_colour=dark
fi

# export functions in bash
if [[ -v BASH_VERSION ]]; then
  export -f sv
  export -f svim
  complete -o nospace -F _cg_complete cg
  complete -o nospace -F _up_complete up
fi

if command -v nvim >/dev/null; then
  alias vim='nvim'
  alias vimpager='nvim -R'
  export MANPAGER='nvim +Man!'
  export EDITOR=nvim
else
  alias vimpager='vim -R'
  export EDITOR=vim
  export MANPAGER="env MAN_PN=1 vim -M +MANPAGER -"
fi
