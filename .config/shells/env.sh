# env compating with POSIX shell
if [ -n "$BASH_VERSION" ]; then
  export SHELL_TYPE=bash
elif [ -n "$ZSH_VERSION" ]; then
  export SHELL_TYPE=zsh
fi

if command -v fd >/dev/null; then
  export FZF_DEFAULT_COMMAND='fd --strip-cwd-prefix --type f --hidden'
  export FZF_ALT_C_COMMAND='fd --strip-cwd-prefix --type d'
elif command -v rg >/dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files 2> /dev/null'
elif command -v ag >/dev/null; then
  export FZF_DEFAULT_COMMAND='ag -g "" 2> /dev/null'
fi

if [[ -f /usr/share/java/lombok/lombok.jar ]]; then
  export JAVA_TOOLS_OPTIONS="-javaagent:/usr/share/java/lombok/lombok.jar -Xbootclasspath/p:/usr/share/java/lombok/lombok.jar"
fi

if [[ -d /usr/lib/jvm/default ]]; then
  export JAVA_HOME=/usr/lib/jvm/default/
fi

if [[ -f ~/.config/user-dirs.dirs ]]; then
  source ~/.config/user-dirs.dirs
  export XDG_DESKTOP_DIR
  export XDG_DOWNLOAD_DIR
  export XDG_TEMPLATES_DIR
  export XDG_PUBLICSHARE_DIR
  export XDG_DOCUMENTS_DIR
  export XDG_MUSIC_DIR
  export XDG_PICTURES_DIR
  export XDG_VIDEOS_DIR
fi

export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline
export MAKEFLAGS="-j $(nproc)"
export SKIM_DEFAULT_COMMAND="${FZF_DEFAULT_COMMAND}"
