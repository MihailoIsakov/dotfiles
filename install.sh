sudo apt install vim-gtk nmap i3 arandr rofi python3-pip bash-completion flake8 curl
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

