source "$HOME/.config/shells/env"
source "$HOME/.config/fish/env.fish"
source "$HOME/.config/fish/functions.fish"
source "$HOME/.config/shells/aliases"


# set -x FZF_ALT_C_COMMAND "find /home/fenuks -type d ! -perm -g+r,u+r,o+r -prune -o -not -path '!/Documents/*' -not -path '*/\.*' -readable"
set -x ENHANCD_COMMAND fzf

function fish_user_key_bindings
    fzf_key_bindings
    # skim_key_bindings
end

# set -g fish_key_bindings fish_vi_key_bindings

function fish_prompt
    powerline-go -error $status -shell bare
end

function fish_greeting
    if test -x /usr/bin/fortune
        fortune
    end
end
