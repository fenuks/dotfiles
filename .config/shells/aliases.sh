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
alias sb='source ~/.bashrc'
alias sf='source ~/.config/fish/config.fish'
