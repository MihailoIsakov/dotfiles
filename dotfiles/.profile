# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# if an ssh session
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    source .sshrc
fi

# add usr local bin
PATH=$PATH:/usr/local/bin/

# setup screens
# /home/mihailo/.screenlayout/lab.sh

# faster keyboard
xset r rate 180 60

# Bash history
HISTSIZE=100000
HISTFILESIZE=100000

# Created by `pipx` on 2022-01-21 17:21:54
export PATH="$PATH:/home/mihailo/.local/bin"

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=$HOME/Devel source /home/mihailo/.local/bin/virtualenvwrapper.sh

# Sensible terminal
export TERM=/home/mihailo/.local/kitty.app/bin/kitty
export TERMINAL=/home/mihailo/.local/kitty.app/bin/kitty

# Background
xsetroot -solid "#111111"

