#! /bin/sh

# exit if any command fails
set -e 

##################################
# Setup the desktop as I like it #
##################################
mkdir -p ~/tools/
mkdir -p ~/dev/
mkdir -p ~/dl/
mkdir -p ~/libs/

################################################
# bare necessities, possibly tied into configs #
################################################
sudo apt install vim-gtk bash-completion mosh wget curl htop 
sudo apt install python3.10 python3-pip python3.10-venv 

# FZF Fuzzy search
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

git config --global user.email "isakov.m@gmail.com"
git config --global user.name  "Mihailo Isakov"
git config pull.rebase false  # merge strategy

###########################
# Laptop power management #
###########################
read -p "Install laptop power management tools? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo apt install powertop tlp smartmontools
    systemctl enable tlp.service
    systemctl mask power-profiles-daemon.service  # https://linrunner.de/tlp/faq/installation.html
fi


#######################################
# desktop setup, don't run on servers # 
#######################################
read -p "Install desktop applications and development environment? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then

    # NVIDIA driver
    read -p "Install NVIDIA driver: nvidia-driver-515 ? " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        sudo apt install nvidia-driver-515
    fi

    # environment, terminal
    sudo apt install i3 polybar rofi 
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    sudo snap install jump 

    # virtualbox
    sudo apt install virtualbox
    # download the DPKG https://www.virtualbox.org/wiki/Linux_Downloads

    # i3-swallow (https://github.com/jamesofarrell/i3-swallow)
    pipx install i3-swallow

    # i3gem 
    cd ~/tools
    git clone git@github.com:MihailoIsakov/i3-groups.git
    cd i3-groups
    git checkout 1a8b823
    pipx install -e .

    # apps
    sudo apt install arandr gnome-screenshot pm-utils pavucontrol zathura nmap gthumb
    sudo snap install xdotool

    # libs, python3-tk is needed for Matplotlib
    sudo apt install npm nodejs python3-tk libncurses5

    # Use pipx or virtualenvwrapper whenever possible
    pip install virtualenv virtualenvwrapper pipx

    # fonts
    sudo apt install fonts-firacode fonts-powerline

    # Greenclip manager 
    wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip -O ~/bin/greenclip

    # pipx install tldr powerline-shell
    # TODO: automate downloading a powerline-go release?

    # TODO: flake8 in pip? 

    # rofi file selector
    # sudo apt install fd-find xsel
    # pip install PyGObject
    # wget --output-document ~/bin/choose https://github.com/theryangeary/choose/releases/download/v1.3.4/choose-x86_64-unknown-linux-gnu
    # chmod +x ~/bin/choose
    
    # Default applications
    #xdg-mime default org.pwmt.zathura.desktop application/pdf

    read -p "Install graphics tools and LibreOffice? " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        sudo apt install inkscape imagemagick gimp
        sudo snap install libreoffice 
    fi

    ###############################
    # Require manual installation #
    ###############################
    # Google Chrome installed from DPKdG
    # Owncloud
fi



