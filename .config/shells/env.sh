export BROWSER=firefox
export CALIBRE_USE_SYSTEM_THEME=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export EDITOR=vim
export ENHANCD_COMMAND=fzf
if [[ ! -v FZF_DEFAULT_COMMAND ]]; then
    export FZF_DEFAULT_COMMAND='fd --type f'
fi
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export GCC_COLORS=auto
export GTK_USE_PORTAL=1
export GPODDER_HOME="${HOME}/Podcasts/"
export HISTCONTROL=ignoreboth
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
export HISTSIZE=100000
export HISTTIMEFORMAT="%d/%m/%y %T "
export HTML_TIDY="${HOME}/.config/tidy.conf"
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
export PATH="${HOME}/.local/bin:${PATH}"
export PYTHON2DOCDIR=/usr/share/doc/python2/html/
export PYTHON3DOCDIR=/usr/share/doc/python/html/
export PYTHONSTARTUP="$HOME/.config/python/pythonrc"
export RUSTFLAGS="-C target-cpu=native"
export RUST_SRC_PATH="${HOME}/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
export SHELLCHECK_OPTS="-e SC1090,SC2034,SC2164"
export SKIM_DEFAULT_COMMAND='git ls-tree -r --name-only HEAD || rg --files'
export SSH_ASKPASS=/usr/bin/ksshaskpass
export SSH_AUTH_SOCK=/tmp/ssh-agent.sock
export UNCRUSTIFY_CONFIG="${HOME}/.config/uncrustify.cfg"
