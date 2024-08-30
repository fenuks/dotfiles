export FIGNORE=__pycache__
export HISTCONTROL=ignoreboth # manually erasing duplicates for better result
export HISTFILE="$XDG_DATA_HOME/history/bash_history"
export PROMPT_COMMAND='history -a' # don't wait to append to history until session ends
