fpath+="$ZDOTDIR/functions"
fpath+='/usr/share/zsh/site-functions'
skip_global_compinit=1

[[ -d '/usr/share/zsh/functions' ]] && for usrplug in /usr/share/zsh/functions/*; fpath+=$usrplug

path+=("$HOME/.local/bin" "$HOME/.cargo/bin")
[[ -n "$NIX_PATH" ]] && typeset -TU NIX_PATH nix_path : && nix_path+="$HOME/.nix-defexpr/channels"

export EDITOR=nvim

## Setup XDG Base Directory specification
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"

