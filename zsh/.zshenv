# --------------------------------------------- #

## Setup XDG Base Directory specification
export HM_SESSION_VARS=~/.nix-profile/etc/profile.d/hm-session-vars.sh
[[ -r "$HM_SESSION_VARS" ]] && source "$HM_SESSION_VARS"

export XDG_DATA_DIRS="$XDG_DATA_DIRS:$HOME/.nix-profile/share"

path+=("$HOME/.local/bin" "$HOME/.cargo/bin")
[[ -d "$XDG_CONFIG_HOME/emacs/bin" ]] && path+=("$XDG_CONFIG_HOME/emacs/bin")
(( $+commands[nix] )) && typeset -TU NIX_PATH nix_path : && nix_path+="$HOME/.nix-defexpr/channels"

fpath+="$ZDOTDIR/functions"
fpath+='/usr/share/zsh/site-functions'
export skip_global_compinit=1

[[ -d '/usr/share/zsh/functions' ]] && for usrplug in /usr/share/zsh/functions/*;do
    fpath+=$usrplug;
done
