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
sudo apt install vim-gtk python3-pip bash-completion mosh wget curl 

git config --global user.email "isakov.m@gmail.com"
git config --global user.name  "Mihailo Isakov"
git config pull.rebase false  # merge strategy


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


    # i3gem 
    cd ~/tools
    git clone git@github.com:MihailoIsakov/i3-groups.git
    cd i3-groups
    git checkout 1a8b823
    pipx install -e .

    # Fuzzy search
    cd ~/tools
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    # apps
    sudo apt install arandr gnome-screenshot pm-utils pavucontrol zathura htop nmap gthumb
    sudo snap install libreoffice xdotool

    # libs, python3-tk is needed for Matplotlib
    sudo apt install npm nodejs python3.10-venv python3-tk libncurses5

    # Use pipx or virtualenvwrapper whenever possible
    pip install virtualenv virtualenvwrapper pipx

    # pipx install tldr powerline-shell
    # TODO: automate downloading a powerline-go release?

    # TODO: flake8 in pip? 

    # fonts
    sudo apt install fonts-firacode fonts-powerline

    # rofi file selector
    # sudo apt install fd-find xsel
    # pip install PyGObject
    # wget --output-document ~/bin/choose https://github.com/theryangeary/choose/releases/download/v1.3.4/choose-x86_64-unknown-linux-gnu
    # chmod +x ~/bin/choose
    
    # Default applications
    xdg-mime default org.pwmt.zathura.desktop application/pdf

    ###############################
    # Require manual installation #
    ###############################
    # Google Chrome installed from DPKdG
    # Owncloud
    # sudo apt install nvidia-driver-495
fi



