#! /bin/bash

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
sudo apt install -y vim-gtk bash-completion mosh wget curl htop python3.10 python3-pip python3.10-venv 

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
    echo "\n"
    sudo apt install powertop tlp smartmontools
    systemctl enable tlp.service
    systemctl mask power-profiles-daemon.service  # https://linrunner.de/tlp/faq/installation.html
fi

################################
# Optionally generate SSH keys #
# TODO: use setup_ssh.sh script
################################
read -p "Generate new RSA keys in .ssh/id_rsa? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    cd ~
    echo "\n"
    ssh-keygen -t ed25519 -C "isakov.m@gmail.com"

    # start agent
    eval "$(ssh-agent -s)"

    # add keys 
    ssh-add ~/.ssh/id_ed25519
fi


read -p "Start SSHD, download pub keys from GitHub, and add them authorized_keys? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then 
    sudo apt install -y openssh-server
    sudo ufw allow ssh
    sudo ufw enable && sudo ufw reload

    mkdir -p .ssh/
    wget https://github.com/MihailoIsakov.keys -O ~/.ssh/authorized_keys

    chmod -R go= ~/.ssh
    chown -R mihailo:mihailo ~/.ssh

    sudo systemctl restart ssh
fi



#######################################
# desktop setup, don't run on servers # 
#######################################
read -p "Install desktop applications and development environment? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "\n"
    # NVIDIA driver
    read -p "Install NVIDIA driver: nvidia-driver-515 ? " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
	echo "\n"
	sudo apt install -y nvidia-driver-515
    fi

    # environment, terminal
    sudo apt install -y i3 polybar rofi compton
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

    # Use pipx or virtualenvwrapper whenever possible
    pip install virtualenv virtualenvwrapper pipx

    # virtualbox
    sudo apt install virtualbox
    # download the DPKG https://www.virtualbox.org/wiki/Linux_Downloads

    # clone and install i3gem if the repo doesn't already exist
    cd ~/tools
    if [ ! -d "i3-groups/" ]
    then
	echo "TEST\n"
	git clone git@github.com:MihailoIsakov/i3-groups.git
	cd i3-groups
	git checkout 1a8b823
	pipx install -e .
    fi

    # apps
    sudo apt install -y arandr gnome-screenshot pm-utils pavucontrol zathura nmap gthumb xdotool

    # libs, python3-tk is needed for Matplotlib
    sudo apt install -y npm nodejs python3-tk libncurses5

    # fonts
    sudo apt install -y fonts-firacode fonts-powerline

    # development
    sudo apt install -y universal-ctags

    # Greenclip manager 
    cd ~
    if [ ! -d "bin/" ]
    then
    	mkdir bin
    fi
    wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip -O ~/bin/greenclip
    chmod +x bin/greenclip

    # pipx install tldr powerline-shell
    # TODO: automate downloading a powerline-go release?
    wget https://github.com/justjanne/powerline-go/releases/download/v1.22.1/powerline-go-linux-amd64 -O ~/bin/powerline-go
    chmod 

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
        sudo apt install -y inkscape imagemagick gimp
        sudo snap install libreoffice 
    fi

    ###############################
    # Require manual installation #
    ###############################
    # Google Chrome installed from DPKdG

    printf "\n\n\n################################################################################"
    printf "# You still need to manually install chrome, dropbox, obsidian, & powerline-go #"
    printf "################################################################################\n\n\n"

fi

sudo apt autoremove

