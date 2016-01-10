
" 1. Pathogen
" 2. LatexBox
" 3. Colorscheme - molokai
" 4. vim-sensible
" 5. vim-airline
" 6. vim-autoclose -
" 7. ctrp.vim
" 8. vim-fugitive
" 9. nerdcommenter
" 10. youcompleteme
" 11. auto-pairs
" 12. tabline
" 13. vim-markdown
 
 
" Reload .vimrc if changed
autocmd! bufwritepost .vimrc source %
 
" Not compatible with VI
set nocompatible

" Start unwrapped
set nowrap

" Indentation 
set autoindent
set smartindent
set cindent
 
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */
 
" use intelligent file completion like in the bash
set wildmode=longest:full
set wildmenu
 
" Enable line numbers
set number

" Higlight search matches
set hlsearch
" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
 
" Syntax highlighting
syntax on 
 
" Basic settings 
filetype plugin indent on
 
" Tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Cursor settings
set cursorline
 
" Timeout to Normal mode
set ttimeoutlen=50
 
" Remove the default mode indicator because we have airline!
set noshowmode
 
" Switch buffers without saving
set hidden
 
" Case insensitive search by default
set ignorecase
 
" Pathogen runtimepath management
execute pathogen#infect()
execute pathogen#helptags()
 
" Theme settings
colorscheme molokai
set t_Co=256
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark
 
" Powerline fonts for vim-airline 
" Remember to set encoding in xshell
let g:airline_powerline_fonts = 1
 
" Airline theme to match
let g:airline_theme = "molokai"
 
" Airline tabs for open buffers -- Install tabline
let g:airline#extensions#tabline#enabled = 1

" Movements
nnoremap <c-k> <c-y>
nnoremap <c-j> <c-e>
nnoremap B ^
nnoremap E $
nnoremap $ <nop>
nnoremap ^ <nop>
nnoremap gV `[v`]

" To allow walking over strings using _, something_like_this
set iskeyword-=_

" Reindent the entire file
map <F7> mzgg=G`z<CR>
 
" Center line in Normal mode
nmap <space> zz
 
" Center while searching
nmap n nzz
nmap N Nzz
 
" Open empty files in insert mode
autocmd VimEnter * if empty(expand("%")) | startinsert | endif

set relativenumber
 
" Vim markdown folding disabled
let g:vim_markdown_folding_disabled=1

" Eclim autocomplete
let g:EclimCompletionMethod = 'omnifunc'

" Vim-auto-save
"let g:auto_save = 1
"let g:auto_save_in_insert_mode = 0

" move swap files to tmp
"set swapfile
"set dir=~/tmp

" Highlight word under cursor
" :autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))

" Folding
set foldclose=all 
set foldcolumn=1 
set foldenable 
set foldmethod=syntax 
set foldopen=all 
set foldlevel=1

" JAVA SPECIFIC. TODO Separate in a file or something.
"map <c-t> :JUnit %
"map <c-o> :JavaImport
"iabbr sout System.out.println(
"au BufRead,BufNewFile *.jsp setfiletype html

" Run current script
map <F1> :!%:p <CR> <CR>

"set clipboard=unnamedplusplus
