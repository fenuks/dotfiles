# If not running interactively, don't do anything
[[ $- != *i* ]] && return

function source_if_exists() {
    [[ -r "$1" ]] && source "$1"
}

function cgit() {
    /usr/bin/git --git-dir="${HOME}/.dotfiles/" --work-tree="${HOME}" "$@"
}

if command -v nvim > /dev/null; then
    function vim() {
        nvim "$@"
    }
fi

function svim() {
    vim -u ~/.config/svim/vimrc "$@"
}

source_if_exists /etc/bashrc
source_if_exists ~/.bashrc.local.before

if [ "${TERMINIX_ID}" ] || [ "${VTE_VERSION}" ]; then
    source /etc/profile.d/vte.sh
fi

export -f cgit

alias chromium-dev='chromium --disable-web-security --user-data-dir --remote-debugging-port=9222'
alias clear="clear && printf \"\\e[3J\""
# alias clear="printf \"\\033c\""
alias dc='docker-compose'
alias eclimd='/usr/lib/eclipse/eclimd'
alias eclim='/usr/lib/eclipse/eclimd'
alias firefox-debug='firefox -start-debugger-server -no-remote'
alias g='git'
alias grep="grep --color=auto"
alias jad-decompile="jad -o -d src-jad -r -s java **/*.class"
alias ls='ls --color --classify --human-readable'
alias ll='ls -l'
alias ll.='ls -la'
alias lls='ls -la --sort=size'
alias llt='ls -la --sort=time'
md () { mkdir -p "$@" && cd "$1"; }
function ssh-kde () {
    ssh-agent -a ${SSH_AUTH_SOCK}
    ssh-add </dev/null
}
function run-ssh-agent {
    ssh-agent -a ${SSH_AUTH_SOCK}
}
alias sm='HOME=~/.spacemacs emacs'
alias spacemacs='HOME=~/.spacemacs emacs'
alias steam-flatpak='flatpak run com.valvesoftware.Steam'
alias steam-wine='wine ${HOME}/.wine/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe -no-cef-sandbox -opengl -fullscreenopengl'

alias check-yapf-config="diff <(yapf --style-help | grep -oP '^[a-zA-Z_0-9]+' | sort) <(grep -oP '^[a-zA-Z_0-9]+' ~/.config/yapf/style | sort)"
alias yaourt-vcs="yaourt -Su --devel"
# faster edition of common files
alias v='vim'
alias vb='vim ~/.bashrc'
alias vd='vim docker-compose.yml'
alias vD='vim Dockerfile'
alias vf='vim ~/.config/fish/config.fish'
alias vh='sudoedit /etc/hosts'
alias vm='vim Makefile'
alias vp='vim PKGBUILD'
alias vR='sudoedit /etc/resolv.conf'
alias vr='vim requirements.txt'
alias vrd='vim requirements-dev.txt'
alias vv='vim ~/.config/nvim/init.vim'

# export PAGER="/usr/local/bin/gvim -f -R -"
export BROWSER=firefox
export CALIBRE_USE_SYSTEM_THEME=1
export EDITOR=vim
export ENHANCD_COMMAND=fzf
if [[ ! -v FZF_DEFAULT_COMMAND ]]; then
    export FZF_DEFAULT_COMMAND='fd --type f'
fi
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export GCC_COLORS=auto
export GPODDER_HOME="${HOME}/Podcasts/"
export HISTCONTROL=ignoreboth
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
export HISTSIZE=100000
export HISTTIMEFORMAT="%d/%m/%y %T "
export JAVA_HOME=$JDK_HOME
export JAVA_TOOLS_OPTIONS="-javaagent:/usr/share/java/lombok/lombok.jar -Xbootclasspath/p:/usr/share/java/lombok/lombok.jar"
export JUPYTER_CONFIG_DIR="${HOME}/.config/jupyter"
export JDK_HOME=/usr/lib/jvm/java-8-openjdk/
export LESS=-R
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline
export MAVEN_OPTS='-Xmx2048m'
export PATH="${PATH}:${HOME}/.local/bin"
export PYTHON2DOCDIR=/usr/share/doc/python2/html/
export PYTHON3DOCDIR=/usr/share/doc/python/html/
export RUSTFLAGS="-C target-cpu=native"
export RUST_SRC_PATH="${HOME}/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
export SHELLCHECK_OPTS="-e SC1090,SC2034,SC2164"
export SKIM_DEFAULT_COMMAND='git ls-tree -r --name-only HEAD || rg --files'
export SSH_ASKPASS=/usr/bin/ksshaskpass
export SSH_AUTH_SOCK=/tmp/ssh-agent.sock
export UNCRUSTIFY_CONFIG="${HOME}/.config/uncrustify.cfg"

set -o vi
# bind 'set show-all-if-ambiguous on'
# bind 'TAB:menu-complete'
shopt -s globstar
# append to history from multiple terminals
shopt -s histappend 
# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber
# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space
# Save multi-line commands as one command
shopt -s cmdhist

complete -cf sudo
complete -cf man
source_if_exists /usr/share/git/completion/git-completion.bash
source_if_exists /usr/share/bash-completion/completions/hg
source_if_exists /usr/share/bash-completion/completions/docker
source_if_exists /usr/share/bash-completion/completions/docker-compose
source_if_exists /usr/share/fzf/key-bindings.bash
source_if_exists /usr/share/fzf/completion.bash
complete -o default -o nospace -F _docker_compose dc
# [[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
if [[ -r "${HOME}/.config/fzf/completions/git.sh" ]]; then 
    source "${HOME}/.config/fzf/completions/git.sh"
    complete -o default -o nospace -F _fzf_complete_git cgit
    complete -o default -o nospace -F _fzf_complete_git g
else
    complete -o default -o nospace -F _git cgit
    complete -o default -o nospace -F _git g
fi
source_if_exists "${HOME}/.config/fzf/completions/hg.sh"
source_if_exists "${HOME}/.config/fzf/completions/docker.sh"
source_if_exists "${HOME}/.enhancd/init.sh"

if [[ -x $(command -v fortune) ]]; then
    fortune
fi
