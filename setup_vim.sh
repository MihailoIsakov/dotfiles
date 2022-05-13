# setup pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# install the molokai theme
mkdir -p ~/.vim/colors
curl ~/.vim/colors/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

# install incsearch 
git clone https://github.com/haya14busa/incsearch.vim ~/.vim/bundle/incsearch.vim
