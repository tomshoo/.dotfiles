# Load colours and then set prompt
# Prompt preview:
# [user@hostname]-[~]
# >>>
autoload -U colors && colors
PS1="%{$fg[blue]%}%B[%b%{$fg[cyan]%}%n%{$fg[grey]%}%B@%b%{$fg[cyan]%}%m%{$fg[blue]%}%B]-%b%{$fg[blue]%}%B[%b%{$fg[white]%}%~%{$fg[blue]%}%B]%b
%{$fg[cyan]%}%B>>>%b%{$reset_color%} "
# Plugins
plugins=(git battery)
# ZSH history file
HISTSIZE=100
SAVEHIST=100
HISTFILE=~/.zsh_history

# Fancy auto-complete
autoload -Uz compinit
zstyle ':completion:*' menu select=0
zmodload zsh/complist
zstyle ':completion:*' format '>>> %d'
compinit
_comp_options+=(globdots) # hidden files are included

# Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

export LD_PRELOAD=""
export EDITOR="vim"
export PATH="$HOME/bin:/usr/lib/ccache/bin/:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/opt/bin:/usr/bin/core_perl:/usr/games/bin:$PATH"

# alias
alias c="clear"
alias cd..="cd .."
alias curl="curl --user-agent 'noleak'"
alias l="ls -ahls --color=auto"
alias r="reset"
alias shred="shred -zf"
alias sl="ls --color=auto"
alias vi="vim"
alias ls="ls --color=auto"
alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias wget="wget -c --user-agent 'noleak'"
alias dd="dd status=progress"
alias cp="cp -i"                          # confirm before overwriting something
alias rm="rm -i"
alias mv="mv -i"
alias df="df -h"                          # human-readable sizes
alias free="free -h"
alias du="du -h"

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

if [ -f ~/.zsh_extra ]; then
    . ~/.zsh_extra
fi

pactui () {
	GROUP_INSTALL=0 
	PACKAGE_INSTALL=0
	REMOVE_PACKAGE=0
	REMOVE_PACKAGE_ALL=0
	REOMVE_PACKAGE_GROUP=0
	[ $3 ] && echo "Unexpected argument $2" && return 1
	if [ -z $1 ]; then PACKAGE_INSTALL=1 else;
	case $1 in
		("--install" | "-i")
			if [ -z $2 ]; then PACKAGE_INSTALL=1 else;
			case $2 in
				("--package" | "-p") PACKAGE_INSTALL=1 ;;
				("--group" | "-g") GROUP_INSTALL=1 ;;
				(*) echo -e "$0: Invalid argument: $2\n" "\rExecute $0 --help to list all arguments" 
					return 1
					;;
			esac
			fi
			;;
		("--remove" | "-r")
			if [ -z $2 ]; then REMOVE_PACKAGE_ALL=1 else;
			case $2 in
				("--explicit" | "-e") REMOVE_PACKAGE=1 ;;
				("--all" | "-a") REMOVE_PACKAGE_ALL=1 ;;
				("--group" | "-g") REOMVE_PACKAGE_GROUP=1 ;;
				(*) echo -e "$0: Invalid argument: $2\n" "\rExecute $0 --help to list all arguments" 
					return 1
					;;
			esac
			fi
			;;
		("--help" | "-h" | "-?") 
			echo -e "\n\rSimple script to install packages on archlinux\n"\
					"\r\tUsage: pacinstall [argument]\n\n"\
					"\rAvailable arguments are:\n\n"\
					"\t--install | -i     Install a package\n"\
					"\t  --package. -p    \tInstall a single package\n"\
					"\t  --group,   -g    \tInstall a package group\n\n"\
					"\t--remove  | -r     Remove a package\n"\
					"\t  --explicit, -e   \tRemove an explictly installed package\n"\
					"\t  --all,      -a   \tRemove packages from all installed packages (dependencies included)\n"\
					"\t  --group,    -g   \tRemove a package group\n"
			;;
		(*) echo -e "$0: Invalid argument: $1\n" "\rExecute $0 --help to list all arguments"
			return 1 ;;
	esac
	fi
	[ $PACKAGE_INSTALL -eq 1 ] && pacman -Sl |\
			awk '{print $1 "/" $2}' |\
			fzf --preview 'pacman -Si {}' \
				--layout=reverse \
				--bind 'enter:execute(sudo pacman -Syu --noconfirm --needed {})' \
			&& printf ''
	[ $GROUP_INSTALL -eq 1 ] && pacman -Sgg | \
			cut -d" " -f1 | \
			uniq | \
			fzf --preview 'pacman -Sgq {}' \
				--layout=reverse \
				--bind 'enter:execute(sudo pacman -Syu --noconfirm --needed {})' \
			&& printf ''
	[ $REMOVE_PACKAGE -eq 1 ] && pacman -Qqet | \
			fzf \
				--preview 'pacman -Qil {}' \
				--layout=reverse \
				--bind 'enter:execute(sudo pacman -Rsunc --noconfirm {})' \
				--bind 'ctrl-r:reload(pacman -Qqet)' \
			&& printf ''
	[ $REMOVE_PACKAGE_ALL -eq 1 ] && pacman -Qq | \
			fzf \
				--preview 'pacman -Qil {}' \
				--layout=reverse \
				--bind 'enter:execute(sudo pacman -Rsunc --noconfirm {})' \
				--bind 'ctrl-r:reload(pacman -Qq)' \
			&& printf ''
	[ $REOMVE_PACKAGE_GROUP -eq 1 ] && pacman -Qgg | \
			cut -d" " -f1 | \
			uniq | \
			fzf  \
				--preview 'pacman -Qgq {}'  \
				--layout=reverse \
				--bind 'enter:execute(sudo pacman -Rsunc --noconfirm {})' \
				--bind 'ctrl-r:reload(pacman -Qgg | cut -d" " -f1 | uniq)' \
			&& printf ''
	return 0
}
