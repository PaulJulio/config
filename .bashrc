# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
export PATH=$PATH:${HOME}/.bash_remote

export PS1="[\u@\h:\l \W]\\$ "
