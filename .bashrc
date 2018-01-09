# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ $TERMINIX_ID  ] || [ $VTE_VERSION  ]; then
    source /etc/profile.d/vte.sh
fi

complete -cf sudo
complete -cf kdesudo
complete -cf man
source /usr/share/git/completion/git-completion.bash

alias chromium-dev='chromium --disable-web-security --user-data-dir --remote-debugging-port=9222'
alias cgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias clear="clear && printf '\e[3J'"
alias dc='docker-compose'
alias eclimd='/usr/lib/eclipse/eclimd'
alias eclim='/usr/lib/eclipse/eclimd'
alias firefox-debug='firefox -start-debugger-server -no-remote'
alias grep="grep --color=auto"
alias jad-decompile="jad -o -d src-jad -r -s java **/*.class"
alias ll='ls -l'
alias ll="ls -l"
alias ls='ls --color=auto'
alias run-ssh-agent='eval `ssh-agent -a /tmp/ssh-agent.sock`'
alias sm='HOME=~/.spacemacs.d emacs'
alias spacemacs='HOME=~/.spacemacs.d/ emacs'
alias steam-wine='wine ${HOME}/.wine/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe -no-cef-sandbox -opengl -fullscreenopengl'
alias vim='nvim'
alias yaourt-vcs="yaourt -Su --devel"

# export PAGER="/usr/local/bin/gvim -f -R -"
export BROWSER=/usr/bin/firefox
export CALIBRE_USE_SYSTEM_THEME=1
export EDITOR=nvim
export GCC_COLORS=auto
export GPODDER_HOME=/home/fenuks/Podcasts/
export HISTCONTROL=ignoreboth
export HISTIGNORE=' *'
export HISTSIZE=10000
export HISTTIMEFORMAT="%d/%m/%y %T "
export JAVA_HOME=$JDK_HOME
export JDK_HOME=/usr/lib/jvm/java-8-openjdk/
export PATH="${PATH}:${HOME}.local/bin"
export PYTHON2DOCDIR=/usr/share/doc/python2/html/
export PYTHON3DOCDIR=/usr/share/doc/python/html/
export PYTHONPATH="${PYTHONPATH}:${HOME}/.config/nvim/plugged/ropevim/"
export PYTHONSTARTUP=${HOME}/.pythonrc
export RUSTFLAGS="-C target-cpu=native"
export RUST_SRC_PATH="${HOME}/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
export SHELLCHECK_OPTS="-e SC2034 -e SC2164"
export SSH_ASKPASS=/usr/bin/ksshaskpass
export SSH_AUTH_SOCK=/tmp/ssh-agent.sock
export TERM='konsole-256color'
export UNCRUSTIFY_CONFIG="${HOME}/.config/uncrustify.cfg"

set -o vi
# bind 'set show-all-if-ambiguous on'
# bind 'TAB:menu-complete'

# fuzzy searchers
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
# export FZF_ALT_C_COMMAND="find /home/fenuks -type d ! -perm -g+r,u+r,o+r -prune -o -not -path '/home/fenuks/Documents/*' -not -path '*/\.*' -readable"
# export FZF_DEFAULT_COMMAND='rg --files 2> /dev/null'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
# export FZF_CTRL_T_COMMAND='ag -g "" 2> /dev/null'
export SKIM_DEFAULT_COMMAND='git ls-tree -r --name-only HEAD || rg --files'

function _update_ps1() {
    PS1="$(powerline-go -error $?)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
