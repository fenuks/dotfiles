# complete -o default -o nospace -F _git cgit

alias chromium-dev='chromium --disable-web-security --user-data-dir --remote-debugging-port=9222'
alias cgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias clear="clear; printf '\e[3J'"
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
alias steam-wine="wine $HOME/.wine/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe -no-cef-sandbox -opengl -fullscreenopengl"
alias steam-flatpak='flatpak run com.valvesoftware.Steam'
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

set -x BROWSER /usr/bin/firefox
set -x CALIBRE_USE_SYSTEM_THEME 1
set -x EDITOR nvim
set -x GCC_COLORS auto
set -x GPODDER_HOME /home/fenuks/Podcasts/
set -x HISTCONTROL ignoreboth
set -x HISTIGNORE "&:[ ]*:exit:ls:bg:fg:history:clear"
set -x HISTSIZE 10000
set -x HISTTIMEFORMAT "%d/%m/%y %T "
set -x JAVA_HOME $JDK_HOME
set -x JAVA_TOOLS_OPTIONS "-javaagent:/usr/share/java/lombok/lombok.jar -Xbootclasspath/p:/usr/share/java/lombok/lombok.jar"
set -x JDK_HOME /usr/lib/jvm/java-8-openjdk/
set -x fish_user_paths $HOME/.local/bin $fish_user_paths
set -x PYTHON2DOCDIR /usr/share/doc/python2/html/
set -x PYTHON3DOCDIR /usr/share/doc/python/html/
set -x PYTHONPATH "$PYTHONPATH:$HOME/.config/nvim/plugged/ropevim/"
set -x PYTHONSTARTUP $HOME/.pythonrc
set -x RUSTFLAGS "-C target-cpu=native"
set -x RUST_SRC_PATH "$HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
set -x SHELLCHECK_OPTS "-e SC2034 -e SC2164"
set -x SSH_ASKPASS /usr/bin/ksshaskpass
set -x SSH_AUTH_SOCK /tmp/ssh-agent.sock
set -x UNCRUSTIFY_CONFIG "$HOME/.config/uncrustify.cfg"

# fzf
# set -x FZF_ALT_C_COMMAND "find /home/fenuks -type d ! -perm -g+r,u+r,o+r -prune -o -not -path '!/Documents/*' -not -path '*/\.*' -readable"
# set -x FZF_DEFAULT_COMMAND 'rg --files 2> /dev/null'
set -x FZF_DEFAULT_COMMAND 'fd --type f'
set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
# set -x FZF_CTRL_T_COMMAND 'ag -g "" 2> /dev/null'
set -x SKIM_DEFAULT_COMMAND 'git ls-tree -r --name-only HEAD || rg --files'
# [[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
# if test -r "$HOME/.enhancd/init.sh"; source "$HOME/.enhancd/init.sh"; end
set -x ENHANCD_COMMAND fzf
