#! /bin/sh

# exit if any command fails
set -e

chmod +x bin/*

ln -s -f $(pwd)/bin/                        ~/
ln -s -f $(pwd)/dotfiles/.profile           ~/
ln -s -f $(pwd)/dotfiles/.bashrc            ~/
ln -s -f $(pwd)/dotfiles/.vimrc             ~/
ln -s -f $(pwd)/dotfiles/.sshrc             ~/
ln -s -f $(pwd)/dotfiles/.xinitrc           ~/
ln -s -f $(pwd)/dotfiles/.inputrc           ~/
ln -s -f $(pwd)/dotfiles/.bash_git          ~/
ln -s -f $(pwd)/dotfiles/.bash_aliases      ~/
ln -s -f $(pwd)/dotfiles/.flake8            ~/

# Not working since ~/bin/kitty is a symlink to ~/.local/kitty.app/bin/kitty
# What's a good way to solve this? 
ln -s    $(pwd)/dotfiles/kitty/             ~/.config/kitty

# FIXME: do we need the / at the end? 
ln -s -f $(pwd)/dotfiles/polybar/           ~/.config/polybar/

mkdir -p ~/.vim/ftplugin
ln -s -f $(pwd)/dotfiles/tex.vim            ~/.vim/ftplugin/

mkdir -p ~/.config/i3/
ln -s -f $(pwd)/dotfiles/i3_config          ~/.config/i3/config

mkdir -p ~/.config/zathura/
ln -s -f $(pwd)/dotfiles/zathurarc          ~/.config/zathura/

mkdir -p ~/.config/powerline-shell/
ln -s -f $(pwd)/dotfiles/powerline-shell/config.json ~/.config/powerline-shell/config.json


