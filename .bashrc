# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ $TERMINIX_ID  ] || [ $VTE_VERSION  ]; then
    source /etc/profile.d/vte.sh
fi

alias chromium-dev='chromium --disable-web-security --user-data-dir --remote-debugging-port=9222'
alias cgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias clear="clear && printf '\e[3J'"
alias dc='docker-compose'
alias eclimd='/usr/lib/eclipse/eclimd'
alias eclim='/usr/lib/eclipse/eclimd'
alias firefox-debug='firefox -start-debugger-server -no-remote'
alias grep="grep --color=auto"
alias jad-decompile="jad -o -d src-jad -r -s java **/*.class"
alias ls='ls --color --classify --human-readable'
alias ll='ls -l'
alias ll.='ls -la'
alias lls='ls -la --sort=size'
alias llt='ls -la --sort=time'
alias run-ssh-agent='eval `ssh-agent -a /tmp/ssh-agent.sock`'
alias sm='HOME=~/.spacemacs.d emacs'
alias spacemacs='HOME=~/.spacemacs.d/ emacs'
alias steam-wine='wine ${HOME}/.wine/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe -no-cef-sandbox -opengl -fullscreenopengl'
alias vim='nvim'
alias check-yapf-config="diff <(yapf --style-help | grep -oP '^[a-zA-Z_0-9]+' | sort) <(grep -oP '^[a-zA-Z_0-9]+' ~/.config/yapf/style | sort)"
alias yaourt-vcs="yaourt -Su --devel"
# faster edition of common files
alias vb='vim ~/.bashrc'
alias vd='vim docker-compose.yml'
alias vD='vim Dockerfile'
alias vh='sudoedit /etc/hosts'
alias vm='vim Makefile'
alias vp='vim PKGBUILD'
alias vR='sudoedit /etc/resolv.conf'
alias vr='vim requirements.txt'
alias vrd='vim requirements-dev.txt'
alias vv='vim ~/.config/nvim/init.vim'

# export PAGER="/usr/local/bin/gvim -f -R -"
export BROWSER=/usr/bin/firefox
export CALIBRE_USE_SYSTEM_THEME=1
export EDITOR=nvim
export ENHANCD_COMMAND=fzf
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export GCC_COLORS=auto
export GPODDER_HOME=/home/fenuks/Podcasts/
export HISTCONTROL=ignoreboth
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
export HISTSIZE=10000
export HISTTIMEFORMAT="%d/%m/%y %T "
export JAVA_HOME=$JDK_HOME
export JAVA_TOOLS_OPTIONS="-javaagent:/usr/share/java/lombok/lombok.jar -Xbootclasspath/p:/usr/share/java/lombok/lombok.jar"
export JDK_HOME=/usr/lib/jvm/java-8-openjdk/
export PATH="${PATH}:${HOME}.local/bin"
export PYTHON2DOCDIR=/usr/share/doc/python2/html/
export PYTHON3DOCDIR=/usr/share/doc/python/html/
export PYTHONPATH="${PYTHONPATH}:${HOME}/.config/nvim/plugged/ropevim/"
export PYTHONSTARTUP=${HOME}/.pythonrc
export RUSTFLAGS="-C target-cpu=native"
export RUST_SRC_PATH="${HOME}/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
export SHELLCHECK_OPTS="-e SC2034 -e SC2164"
export SKIM_DEFAULT_COMMAND='git ls-tree -r --name-only HEAD || rg --files'
export SSH_ASKPASS=/usr/bin/ksshaskpass
export SSH_AUTH_SOCK=/tmp/ssh-agent.sock
export UNCRUSTIFY_CONFIG="${HOME}/.config/uncrustify.cfg"

set -o vi
# bind 'set show-all-if-ambiguous on'
# bind 'TAB:menu-complete'
shopt -s globstar
# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber
# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space
# Save multi-line commands as one command
shopt -s cmdhist

complete -cf sudo
complete -cf kdesudo
complete -cf man
source /usr/share/git/completion/git-completion.bash
source /usr/share/bash-completion/completions/hg
complete -o default -o nospace -F _git cgit
[[ -r '/usr/share/fzf/key-bindings.bash' ]] && source /usr/share/fzf/key-bindings.bash
[[ -r '/usr/share/fzf/completion.bash' ]] && source /usr/share/fzf/completion.bash
# [[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
[[ -r "${HOME}/.config/fzf/completions/fzf-hg.sh" ]] && source "${HOME}/.config/fzf/completions/fzf-hg.sh"
[[ -r "${HOME}/.enhancd/init.sh" ]] && source "${HOME}/.enhancd/init.sh"


function _update_ps1() {
    PS1="$(powerline-go -error $?)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
