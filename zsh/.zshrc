! [[ -o interactive ]] && return

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
export HIST_STAMPS="yyyy-mm-dd"

setopt auto_cd
setopt chase_links
setopt pushd_silent
setopt pushd_to_home
setopt auto_param_keys
setopt bad_pattern
setopt append_history
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt aliases
setopt interactive_comments
setopt hash_cmds
setopt hash_executables_only
setopt prompt_subst

unsetopt beep

function __has_command() { command -v "$1" &> /dev/null; }
function __load_file()   { [ -f "$1" ] && source "$1" }

__load_file "$ZDOTDIR/zsh_vcs"
__load_file "$ZDOTDIR/zsh_abbrevations"
__load_file "$ZDOTDIR/zsh_prompt"
__load_file "$ZDOTDIR/zsh_aliases"
[[ -n "$(command ls -A "$ZDOTDIR/functions")" ]] && autoload -Uz "$ZDOTDIR/functions/"*

if (( $+functions[zsh_add_snippet] )); then
    zsh_add_snippet 'omz:lib/history.zsh'
    zsh_add_snippet 'omz:lib/key-bindings.zsh'

    __load_file /usr/share/fzf/key-bindings.zsh ||
        __load_file /usr/share/doc/fzf/examples/key-bindings.zsh ||
        zsh_add_snippet 'fzf:shell/key-bindings.zsh'
fi

if (( $+functions[zsh_add_plugin] )); then
    zsh_add_plugin 'zsh-users/zsh-syntax-highlighting'
    zsh_add_plugin 'zsh-users/zsh-autosuggestions'
    zsh_add_plugin 'zsh-users/zsh-completions'
fi

zstyle ':completion:*' menu select
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

(( $+commands[zoxide] )) && source <(zoxide init zsh --cmd zd)
(( $+commands[direnv] )) && source <(direnv hook zsh)

(( $+functions[zsh_greeting] )) && zsh_greeting

set-window-title() {
  window_title="\e]0;${${PWD/#"$HOME"/~}/projects/p}\a"
  echo -ne "$window_title"
}; set-window-title
add-zsh-hook precmd set-window-title

bindkey ' '  _expand_abbrevation
bindkey '^ ' magic-space
bindkey -M isearch ' ' magic-space

autoload -Uz compinit     && compinit
autoload -Uz bashcompinit && bashcompinit

