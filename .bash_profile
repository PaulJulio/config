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

alias cleangit='cd ~/git/webapp; git checkout master; git branch -d `git branch --merged | sed -e s/\\*//g`;'

export PS1="[\u@\h:\l \W]\\$ "
alias fixdns="sudo killall -HUP mDNSResponder"

if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"
fi
