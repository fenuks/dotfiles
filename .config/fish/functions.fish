# private
function source_if_exists
    [[ -r "$1" ]] && source "$1"
end

function md
    mkdir -p "$argv" && cd "$1"
end

function ssh-kde
    ssh-agent -a "$SSH_AUTH_SOCK"
    ssh-add </dev/null
end

function run-ssh-agent
    ssh-agent -a "$SSH_AUTH_SOCK"
end

# exported
function cgit
    git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$argv"
end

if command -v nvim > /dev/null
    function vim
        nvim "$argv"
    end

    function vimpager
        nvim -R "$argv"
    end
    export MANPAGER="nvim -c 'set ft=man' -"
else
    function vimpager
        vim -R "$argv"
    end
    export MANPAGER="env MAN_PN=1 vim -M +MANPAGER -"
end

function sv
    if [[ -f .env/bin/activate ]]
        source .env/bin/activate
    else if [[ -f env/bin/activate ]]
        source env/bin/activate
    else if [[ -f venv/bin/activate ]]
        source venv/bin/activate
    else if [[ -f .venv/bin/activate ]]
        source .venv/bin/activate
    end
end

function svim
    vim -u ~/.config/svim/vimrc "$argv"
end

