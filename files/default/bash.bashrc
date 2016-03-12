# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# add some history control
export HISTCONTROL=ignoreboth
export HISTFILESEIZE=5000
export HISTIGNORE=df:du:ls:exit\ :exit:free\ :free
#export TMOUT=60

# screen isolation
mkdir -p ~/.screen; chmod 700 ~/.screen; export SCREENDIR=~/.screen

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

HNAME=$(hostname -f | head -c-16)
[ -f /etc/cname ] && HNAME=$(cat /etc/cname | head -c-28)

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
PS1='${debian_chroot:+($debian_chroot)}\u@$HNAME:\w\$ '

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@$HNAME\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    ;;
esac

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/lib/command-not-found -- "$1"
                   return $?
                elif [ -x /usr/share/command-not-found/command-not-found ]; then
		   /usr/share/command-not-found/command-not-found -- "$1"
                   return $?
		else
		   printf "%s: command not found\n" "$1" >&2
		   return 127
		fi
	}
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
	eval `dircolors -b`
	export LS_OPTIONS='--color=auto'

	alias ls='ls $LS_OPTIONS'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -lA'
alias l='ls -AlF'

alias o='less'
alias ..='cd ..'
alias ...='cd ../..'

alias rd=rmdir
alias md='mkdir -p'
alias beep='echo -en "\x07"'
alias dir='ls --format=vertical'
alias vdir='ls --format=long'

# Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
