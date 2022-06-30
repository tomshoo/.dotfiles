if [ -f /usr/share/git/completion/git-prompt.sh ]; then
  source /usr/share/git/completion/git-prompt.sh
fi
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=1

# exports
export PATH="${HOME}/.bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:"
export PATH="${PATH}/usr/local/sbin:/opt/bin:/usr/bin/core_perl:/usr/games/bin:"

if [[ $EUID -eq 0 ]]; then
    export PS1="\u@\h:\W:\$(__git_ps1 ' (%s)')$> "
else
    export PS1="\u@\h:\W:\$(__git_ps1 ' (%s)')$> "
fi

export LD_PRELOAD=""
export EDITOR="vim"

# alias
alias ls="ls --color"
alias vi="vim"
alias shred="shred -zf"
#alias python="python2"
alias wget="wget -U 'noleak'"
alias curl="curl --user-agent 'noleak'"

# If you want to add more aliases please consider adding them to .bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# If you want to add more startup commands please consider adding them to .bash_extra
if [ -f ~/.bash_extra ]; then
    . ~/.bash_extra
fi

# source files
[ -r /usr/share/bash-completion/completions ] &&
  . /usr/share/bash-completion/completions/*

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ $- = *i* ]] && bind TAB:menu-complete
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"
set 'completion-ignore-case on'

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
