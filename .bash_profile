#!/bin/bash
EDITOR=/usr/bin/vim
export EDITOR
export TERM=xterm-256color

function installsshkey() {
 mkdir -p ~/.ssh
 touch ~/.ssh/authorized_keys
 chmod 600 ~/.ssh/authorized_keys
 cat ~/.keys/square.pub >> ~/.ssh/authorized_keys
 cat ~/.keys/pauljulio.pub >> ~/.ssh/authorized_keys
}

function mkgif() {
	if [ $# -ne 1 ]; then
		echo >&2 'Error: missing argument for file to convert'
		echo >&2 'Create a file on your Mac with cmd+shift+5'
		return 1
	fi
	echo 'If you encounter errors, ensure you: brew install ffmpeg gifsicle'
    INPUT="$1"
	if ! [ -f $INPUT ]; then
		echo >&2 'Argument 1 not a file. Exiting'
		return 1
	fi
    TMPDIR="$(mktemp -d -t palette)"
    TMPFILE="$tmpdir/palette.png"
    ffmpeg -i "$INPUT" -vf palettegen "$TMPFILE" &&
        (ffmpeg -i "$INPUT" -i "$TMPFILE" -lavfi paletteuse -f gif - | \
        gifsicle --optimize=3 --delay=3 --output -)
}

alias cleangit='cd ~/git/webapp; git checkout master; git branch -d `git branch --merged | sed -e s/\\*//g`;'

export PS1="[\u@\h:\l \W]\\$ "
alias fixdns="sudo killall -HUP mDNSResponder"

if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"
fi
