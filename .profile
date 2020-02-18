export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_RUNTIME_DIR="/run/user/${UID}"

export ATOM_HOME="$XDG_DATA_HOME"/atom
export CALIBRE_USE_SYSTEM_THEME=1
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME"/ccache.config
export CCACHE_DIR="$XDG_CACHE_HOME"/ccache 
export GTK_USE_PORTAL=1
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export JUPYTER_CONFIG_DIR="$HOME/.config/jupyter"
export KODI_DATA="${XDG_DATA_HOME}/kodi"
export KODI_HOME="${XDG_DATA_HOME}/kodi"
export KODI_TEMP="${XDG_RUNTIME_DIR}/kodi"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"
export PSQL_HISTORY="$XDG_CACHE_HOME/psql_history"
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export SQLITE_HISTORY=$XDG_CACHE_HOME/sqlite_history
export SSH_AUTH_SOCK=/tmp/ssh-agent.sock

alias vim=nvim
