sudo apt install vim-gtk nmap i3 arandr rofi python3-pip bash-completion flake8
# sudo apt install nvidia-driver-495

###################################################
# Use pipx or virtualenvwrapper whenever possible #
###################################################
pip install virtualenv virtualenvwrapper pipx

#############################################
# Setup a ~/tools/ directory for all clones #
#############################################
mkdir -p ~/tools/
cd ~/tools
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

###############################
# Require manual installation #
###############################

# Google Chrome installed from DPKdG
# Fira Code 
# Kitty

##################
# Setup dotfiles #
##################
mkdir -p ~/.config/i3/
ln -s -f $(pwd)/dotfiles/.profile      ~/
ln -s -f $(pwd)/dotfiles/.bashrc       ~/
ln -s -f $(pwd)/dotfiles/.vimrc        ~/
ln -s -f $(pwd)/dotfiles/.sshrc        ~/
ln -s -f $(pwd)/dotfiles/.inputrc      ~/
ln -s -f $(pwd)/dotfiles/.bash_git     ~/
ln -s -f $(pwd)/dotfiles/.bash_aliases ~/
ln -s -f $(pwd)/dotfiles/.flake8       ~/
ln -s -f $(pwd)/dotfiles/i3_config     ~/.config/i3/config
