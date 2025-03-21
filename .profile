export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_RUNTIME_DIR="/run/user/${UID}"

export ATOM_HOME="$XDG_DATA_HOME"/atom
export CALIBRE_USE_SYSTEM_THEME=1
export CARGO_HOME="$XDG_CONFIG_HOME"/cargo
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME"/ccache.config
export CCACHE_DIR="$XDG_CACHE_HOME"/ccache
export GPODDER_HOME="$HOME/Audycje/"
# export GTK_USE_PORTAL=1
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$HOME/.config/jupyter"
export KODI_DATA="${XDG_DATA_HOME}/kodi"
export KODI_HOME="${XDG_DATA_HOME}/kodi"
export KODI_TEMP="${XDG_RUNTIME_DIR}/kodi"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/rg/ripgreprc"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export SQLITE_HISTORY=$XDG_DATA_HOME/history/sqlite_history
export SSH_AUTH_SOCK=/tmp/ssh-agent.sock
export SYSTEMD_EDITOR=nvim
export XCOMPOSEFILE="$XDG_CONFIG_HOME/X11/xcompose"
export XCOMPOSECACHE="$XDG_CACHE_HOME/X11/xcompose"
export SSH_ASKPASS=/usr/bin/ksshaskpass
export GOPROXY=direct

alias vim=nvim

if [[ -f ~/.config/user-dirs.dirs ]]; then
    source ~/.config/user-dirs.dirs
fi

if [[ -f ~/.config/shells/profile.after.local.sh ]]; then
    source ~/.config/shells/profile.after.local.sh
fi
