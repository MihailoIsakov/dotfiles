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
ln -s -f $(pwd)/dotfiles/kitty.conf         ~/.config/kitty/
ln -s -f $(pwd)/dotfiles/current-theme.conf ~/.config/kitty/

mkdir -p ~/.config/i3/
ln -s -f $(pwd)/dotfiles/i3_config          ~/.config/i3/config
