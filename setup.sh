sudo apt install vim-gtk nmap i3 arandr rofi python3-pip bash-completion flake8
# sudo apt install nvidia-driver-495

pip install virtualenv virtualenvwrapper pipx

# Google Chrome installed from DPKdG
# Fira Code 
# Kitty

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install


##################
# Setup dotfiles #
##################
mkdir -p ~/.config/i3/
ln -s $(pwd)/dotfiles/i3_config ~/.config/i3/config
