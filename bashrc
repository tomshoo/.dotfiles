#!/usr/bin/env bash
# shellcheck source=/dev/null

export EDITOR=nvim
export BASH_DOT_DIR="$HOME/.config/bash"
export BASH_PLUG_DIR="$BASH_DOT_DIR/plugins"

__nix_channel_home="$HOME/.nix-defexpr/channels"
if [[ -n "$NIX_PATH" ]] && echo "$NIX_PATH" | grep -vq "$__nix_channel_home"; then
    export NIX_PATH="$NIX_PATH:$__nix_channel_home"
fi
unset __nix_channel_home

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export FPATH="$BASH_DOT_DIR/functions:$HOME/.bash/functions"

has_command() { command -v "$@" &> /dev/null; }

if [[ -d "$BASH_PLUG_DIR" ]] && [[ -n "$(ls -A "$BASH_PLUG_DIR")" ]]; then
    for plugin in "$BASH_PLUG_DIR"/*; do source "$plugin"; done
fi

# shellcheck disable=SC2046
# shellcheck disable=SC2086
has_command autoload && autoload $(IFS=:; echo $FPATH)

has_command zoxide   && eval "$(zoxide init bash --cmd zd)"
has_command direnv   && eval "$(direnv hook bash)"
has_command starship && echo "$SHELL" | grep bash -q && eval "$(starship init bash)" || PS1='[\u@\h \W]\$ '

alias ls='ls --color=auto'
alias grep='grep --color=auto'

has_command autoload && alias re-autoload='autoload $(IFS=:; echo $FPATH)'

prepend_path "$HOME/.local/bin"
prepend_path "$HOME/.cargo/bin"
