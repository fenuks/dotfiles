# private
function source_if_exists() {
    [[ -r "$1" ]] && source "$1"
}

function md() { mkdir -p "$@" && cd "$1"; }

function ssh-kde () {
    ssh-agent -a "${SSH_AUTH_SOCK}"
    ssh-add </dev/null
}
function run-ssh-agent {
    ssh-agent -a "${SSH_AUTH_SOCK}"
}

# exported
function cgit() {
    /usr/bin/git --git-dir="${HOME}/.dotfiles/" --work-tree="${HOME}" "$@"
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
    export -f cgit
    export -f vimpager
    export -f sv
    export -f svim
fi