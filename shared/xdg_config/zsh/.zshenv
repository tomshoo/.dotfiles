# --------------------------------------------- #

## Setup XDG Base Directory specification

export XDG_DATA_DIRS="/usr/share:/usr/local/share:$XDG_DATA_DIRS"

path+=("$HOME/.local/bin" "$HOME/.cargo/bin")
[[ -d "$XDG_CONFIG_HOME/emacs/bin" ]] && path+=("$XDG_CONFIG_HOME/emacs/bin")
(( $+commands[nix] )) && typeset -TU NIX_PATH nix_path : && nix_path+="$HOME/.nix-defexpr/channels"

fpath+="$ZDOTDIR/functions"
fpath+='/usr/share/zsh/site-functions'
export skip_global_compinit=1

[[ -d '/usr/share/zsh/functions' ]] && for usrplug in /usr/share/zsh/functions/*;do
    fpath+=$usrplug;
done
