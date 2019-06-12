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

if command -v nvim > /dev/null; then
    function vim() {
        nvim "$@"
    }

    function vimpager() {
        nvim -R "$@"
    }
    export MANPAGER="nvim -c 'set ft=man' -"
    [[ -v BASH_VERSION ]] && export -f vim
else
    function vimpager() {
        vim -R "$@"
    }
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


# export functions in bash
if [[ -v BASH_VERSION ]]; then
    export -f vimpager
    export -f sv
    export -f svim
fi
