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

source /home/mihailo/bin/rebuild_path.sh

# if an ssh session
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    source ~/.sshrc
fi

# Bash history
HISTSIZE=100000
HISTFILESIZE=100000

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=$HOME/Devel source /home/mihailo/.local/bin/virtualenvwrapper.sh

# Sensible terminal
export TERM=/home/mihailo/.local/kitty.app/bin/kitty
export TERMINAL=/home/mihailo/.local/kitty.app/bin/kitty

# TODO: move to i3 config
# Wallpaper color
xsetroot -solid "#111111"

# BoolSi verilate project installation script says we need this
export CXX=g++
export SYSTEMC_HOME=/opt/systemc
export SYSTEMC_INCLUDE=/opt/systemc/include
export SYSTEMC_LIBDIR=/opt/systemc/lib

. "$HOME/.cargo/env"

