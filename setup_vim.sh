#! /bin/sh

# exit if any command fails
set -e

# setup the undo history directory
mkdir ~/.vim/undodir

# install the molokai theme
mkdir -p ~/.vim/colors
curl https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim --output ~/.vim/colors/molokai.vim

# setup pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# install fugitive
mkdir -p ~/.vim/pack/tpope/start
cd ~/.vim/pack/tpope/start
git clone https://tpope.io/vim/fugitive.git 
git clone https://tpope.io/vim/sleuth.git
vim -u NONE -c "helptags fugitive/doc" -c q
vim -u NONE -c "helptags sleuth/doc" -c q


git clone https://github.com/vim-airline/vim-airline          ~/.vim/bundle/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes   ~/.vim/bundle/vim-airline-themes
git clone https://github.com/preservim/nerdcommenter.git      ~/.vim/bundle/nerdcommenter
git clone https://github.com/haya14busa/incsearch.vim         ~/.vim/bundle/incsearch.vim
git clone https://github.com/easymotion/vim-easymotion        ~/.vim/bundle/vim-easymotion
git clone https://github.com/airblade/vim-gitgutter.git       ~/.vim/bundle/vim-gitgutter
git clone https://github.com/godlygeek/tabular                ~/.vim/bundle/tabular
git clone https://github.com/preservim/vim-textobj-sentence   ~/.vim/bundle/vim-textobj-sentence
git clone https://github.com/lervag/vimtex                    ~/.vim/bundle/vimtex
git clone https://github.com/junegunn/goyo.vim                ~/.vim/bundle/goyo.vim
git clone https://github.com/junegunn/limelight.vim           ~/.vim/bundle/limelight.vim
git clone https://github.com/SirVer/ultisnips                 ~/.vim/bundle/ultisnips
git clone https://github.com/ludovicchabant/vim-gutentags.git ~/.vim/bundle/vim-gutentags.git
git clone https://github.com/matze/vim-tex-fold               ~/.vim/bundle/vim-tex-fold.git

# coc.nvim setup 
curl -sL install-node.vercel.app/lts | sudo bash
git clone https://github.com/neoclide/coc.nvim ~/.vim/bundle/coc.nvim
cd ~/.vim/bundle/coc.nvim
npm install


