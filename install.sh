# bare necessities
sudo apt install vim-gtk nmap i3 arandr rofi python3-pip bash-completion flake8 curl htop

# libs
sudo apt install python3.10-venv

# less essential
sudo apt install gnome-screenshot i3blocks pm-utils mosh fonts-firacode pavucontrol
# sudo apt install nvidia-driver-495

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | /dev/stdin

###################################################
# Use pipx or virtualenvwrapper whenever possible #
###################################################
pip install virtualenv virtualenvwrapper pipx

pipx install tldr powerline-shell

#############################################
# Setup a ~/tools/ directory for all clones #
#############################################
mkdir -p ~/tools/

# FZF
cd ~/tools
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

###############################
# Require manual installation #
###############################
# Google Chrome installed from DPKdG
# Owncloud

