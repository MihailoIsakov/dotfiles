# setup pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# install fugitive
mkdir -p ~/.vim/pack/tpope/start
cd ~/.vim/pack/tpope/start
git clone https://tpope.io/vim/fugitive.git
vim -u NONE -c "helptags fugitive/doc" -c q

# install airline
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes

# install NERD commenter
cd ~/.vim/bundle/
git clone https://github.com/preservim/nerdcommenter.git

# install the molokai theme
mkdir -p ~/.vim/colors
curl ~/.vim/colors/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

# install incsearch 
git clone https://github.com/haya14busa/incsearch.vim ~/.vim/bundle/incsearch.vim

# install easymotion
git clone https://github.com/easymotion/vim-easymotion ~/.vim/bundle/vim-easymotion

# install gitgutter
git clone https://github.com/airblade/vim-gitgutter.git ~/.vim/bundle/vim-gitgutter

# coc.nvim setup 
curl -sL install-node.vercel.app/lts | bash
cd ~/.vim/bundle
git clone https://github.com/neoclide/coc.nvim

# vimtex setup
cd ~/.vim/bundle
git clone https://github.com/lervag/vimtex

