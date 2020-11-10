# private
function source_if_exists() {
    [[ -r "$1" ]] && source "$1"
}

function md() { mkdir -p "$@" && cd "$1"; }

function ssh-kde () {
    ssh-agent -a "${SSH_AUTH_SOCK}"
    ssh-add </dev/null
}

function run-ssh-agent() {
    ssh-agent -a "${SSH_AUTH_SOCK}"
}

function rcd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$(pwd)}" --show-only-dirs
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

find-up() {
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

get_terminal_bg() {
 if [ -z "${TERM_BG_BRIGHT}" ]; then
    stty -echo 2> /dev/null
    echo -ne '\e]11;?\a'
    IFS=: read -rt 0.1 -d $'\a' x bg
    stty echo 2>/dev/null
    export TERM_BG_BRIGHT=$((((0x${bg:0:2} * 299 + 0x${bg:6:2} * 587 + 0x${bg:12:2} * 114) / 1000) < 156))
    if [[ "${TERM_BG_BRIGHT}" -eq 1 ]]; then
        export BAT_THEME=OneHalfLight
    else
        export BAT_THEME=ansi-dark
    fi
 fi
}

get_terminal_bg

function bak() {
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

function prune-history() {
    # remove simple commands having less than three words from history
    if [[ ! "${HISTFILE:-}" ]]; then
        echo "ERROR: Unset HISTFILE"
        return
    fi

    # tac "${HISTFILE}" | awk '!x[$0]++' | grep -P '^([^ \\]+(?<!\\) +){2,}.+$' --color=none >| /tmp/history-pruned
    tac "${HISTFILE}" | awk '!x[$0]++' >| /tmp/history-pruned
    tac /tmp/history-pruned >| "${HISTFILE}"
    history -c
    history -r

}

if command -v nvim > /dev/null; then
    function vim() {
        nvim "$@"
    }

    function vimpager() {
        nvim -R "$@"
    }
    export MANPAGER="nvim -c 'set ft=man' -"
    export EDITOR=nvim
    [[ -v BASH_VERSION ]] && export -f vim
else
    function vimpager() {
        vim -R "$@"
    }
    export EDITOR=vim
    export MANPAGER="env MAN_PN=1 vim -M +MANPAGER -"
fi

function sv() {
    if [[ -f .env/bin/activate ]]; then
        source .env/bin/activate
    elif [[ -f env/bin/activate ]]; then
        source env/bin/activate
    elif [[ -f venv/bin/activate ]]; then
        source venv/bin/activate
    fi
}

function svim() {
    vim -u ~/.config/svim/vimrc "$@"
}

# function for git-fzf completions
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% "$@" --border
}

gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

help_vmap() {
    rg '^\s*(v|c|n|i|o|x)?(nnore)?map' ~/.config/nvim/
}


# export functions in bash
if [[ -v BASH_VERSION ]]; then
    export -f vimpager
    export -f sv
    export -f svim
fi
