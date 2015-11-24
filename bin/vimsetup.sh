#!/bin/bash
mkdir -p ~/.vim/autoload ~/.vim/bundle; \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
 
./link_vimrc.sh
 
mkdir -p ~/.vim/colors
curl -Sso ~/.vim/colors/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
 
 
mkdir -p ~/.vim/bundle
git clone git://github.com/LaTeX-Box-Team/LaTeX-Box.git ~/.vim/bundle/LaTeX-Box
git clone git://github.com/tpope/vim-sensible.git ~/.vim/bundle/vim-sensible
 
 
mkdir ./fonts
git clone https://github.com/Lokaltog/powerline-fonts ./fonts
mkdir ~/.fonts
cp ./fonts/UbuntuMono/Ubuntu* ~/.fonts
 
git clone https://github.com/bling/vim-airline ~/.vim/bundle/vim-airline
### change terminal font to a powerline thing..
 
git clone https://github.com/kien/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
 
git clone git://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive
 
git clone https://github.com/scrooloose/nerdcommenter.git ~/.vim/bundle/nerdommenter
 
#git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
#cd ~/.vim/bundle/YouCompleteMe
#git submodule update --init --recursive
#./install.sh --clang-completer
 
git clone git://github.com/mkitt/tabline.vim.git ~/.vim/bundle/tabline.vim
 
git clone https://github.com/plasticboy/vim-markdown.git ~/.vim/bundle/vim-markdown
 
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
 
git clone https://github.com/jistr/vim-nerdtree-tabs.git ~/.vim/bundle/vim-nerdtree-tabs
