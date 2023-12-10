path+=("$HOME/.local/bin" "$HOME/.cargo/bin")
[[ -d "$XDG_CONFIG_HOME/emacs/bin" ]] && path+=("$XDG_CONFIG_HOME/emacs/bin")
[[ -z "$EDITOR" ]] && export EDITOR=nvim

! [[ -o interactive ]] && return

function __load_file()   { [ -r "$1" ] && source "$1"; }

zstyle ':completion:*' menu select
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

__load_file "$ZDOTDIR/zsh_pre_compinit"
__load_file "$ZDOTDIR/opam.zsh"

autoload -Uz compinit     && compinit
autoload -Uz bashcompinit && bashcompinit

(( $+commands[zoxide] ))   && source <(zoxide init zsh --cmd cd)
(( $+commands[direnv] ))   && source <(direnv hook zsh)
(( $+commands[starship] )) && source <(starship init zsh --print-full-init)

(( $+functions[zsh_greeting] )) && zsh_greeting

__load_file /usr/share/fzf/key-bindings.zsh || __load_file /usr/share/doc/fzf/examples/key-bindings.zsh || zsh_add_snippet 'fzf:shell/key-bindings.zsh'

set-window-title() {
  window_title="\e]0;${${PWD/#"$HOME"/~}/projects/p}\a"
  echo -ne "$window_title"
}; set-window-title
add-zsh-hook precmd set-window-title

bindkey ' '  _expand_abbrevation
bindkey '^ ' magic-space
bindkey -M isearch ' ' magic-space
