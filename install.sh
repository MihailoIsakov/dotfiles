# bare necessities
sudo apt install vim-gtk nmap i3 arandr rofi python3-pip bash-completion curl htop zathura

# libs
sudo apt install python3.10-venv

# less essential
sudo apt install gnome-screenshot pm-utils mosh fonts-firacode pavucontrol polybar

# sudo apt install nvidia-driver-495
sudo snap install libreoffice
# necessary for matplotlib
sudo apt install python3-tk

# rofi file selector
sudo apt install fd-find xsel
pip install PyGObject
wget --output-document ~/bin/choose https://github.com/theryangeary/choose/releases/download/v1.3.4/choose-x86_64-unknown-linux-gnu
chmod +x ~/bin/choose

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | /dev/stdin

###################################################
# Use pipx or virtualenvwrapper whenever possible #
###################################################
pip install virtualenv virtualenvwrapper pipx

pipx install tldr powerline-shell

# flake8 in pip? 

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


# Default applications
xdg-mime default org.pwmt.zathura.desktop application/pdf
