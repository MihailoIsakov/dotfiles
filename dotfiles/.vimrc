""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Visuals                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
set relativenumber

" Start unwrapped                                                                                                       
set nowrap                                                                                                                                  
" Don't break lines                                                                                                     
set textwidth=0                                                                                                         
set wrapmargin=0  
set nofixendofline

" Syntax highlighting
syntax on

" Remove the default mode indicator because we have airline!
set noshowmode

" Switch buffers without saving
set hidden

" Fold background color
hi Folded ctermbg=235

" Theme settings
colorscheme molokai
let g:rehash256 = 1
set background=dark
" Airline theme to match
let g:airline_theme = "molokai"
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

" Airline tabs for open buffers -- Install tabline
let g:airline#extensions#tabline#enabled = 1
"set laststatus=2

set guifont=DejaVu\ Sans:s12

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Highlight non-ascii characters
highlight nonascii guibg=Red ctermbg=1 term=standout
au BufReadPost * syntax match nonascii "[^\u0000-\u007F]"

" Kitty background stuff
" let &t_ut=''


" Disable Background Color Erase (BCE) so that color schemes
" work properly when Vim is used inside tmux and GNU screen.
" if &term =~ '256color'
"     set t_ut=
" endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Keybindings                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" X copy and paste to F keys                                                                                                                
map <F9> "+y                                                                                                               
map <F10> "+p 

nnoremap <c-k> <c-y>
nnoremap <c-j> <c-e>
nnoremap B ^
nnoremap E $
vnoremap B ^
vnoremap E $
nnoremap gV `[v`]

" Indentation in visual mode
vmap < <gv
vmap > >gv

" To allow walking over strings using _, something_like_this
" set iskeyword-=_

" Center line in Normal mode
nmap <space> zz

" Center while searching
nmap n nzz
nmap N Nzz

" Converts hjkl to jkl;, the 'gj' and 'gk' allow for moving accross soft wraps
noremap <buffer> <silent> k gj
noremap <buffer> <silent> l gk
noremap j h
noremap k j
noremap l k
noremap ; l

" Replace selection on Ctrl+r
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" change buffers on ctrl+n (next buffer) and ctrl+p (previous buffer)
map <c-n> :bn<CR>
map <c-p> :bp<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Low level behavior                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Timeout to Normal mode
set ttimeoutlen=50

" Reload .vimrc if changed
autocmd! bufwritepost .vimrc source %

" Don't wipe clipboard when exiting vim 
autocmd VimLeave * call system('echo ' . shellescape(getreg('+')) .
            \ ' | xclip -selection clipboard')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Formatting                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic settings
filetype plugin indent on

" Tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Text width
set tw=120

" Cursor settings
set cursorline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Search                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Case insensitive search by default
set ignorecase
set smartcase

" Higlight search matches
set hlsearch
" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>


" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z\ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
   let @/ = ''
   if exists('#auto_highlight')
     au! auto_highlight
     augroup! auto_highlight
     setl updatetime=4000
     echo 'Highlight current word: off'
     return 0
  else
    augroup auto_highlight
    au!
    au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
  return 1
 endif
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Plugins                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pathogen runtimepath management
execute pathogen#infect()
"execute pathogen#helptags()

" Gitgutter: 
set updatetime=100
let g:gitgutter_diff_args = '-w'
let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn
highlight GitGutterAdd ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1
highlight GitGutterChangeDelete ctermfg=4

" recursively search up for tags file
set tags=tags;/

" Easymotion 
map <Leader> <Plug>(easymotion-prefix)

" Incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      Language specific 		             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python specific
let g:syntastic_python_checkers=['flake8']
autocmd FileType python map <buffer> <c-f> :call Flake8()<CR>
let g:flake8_show_in_file=1
let g:flake8_show_quickfix=0
let g:flake8_show_in_gutter=0
" 
" " Disable line size checking
" autocmd BufWritePost *.py call Flake8()

" let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"       

" Ctags setup
let g:clang_library_path='/usr/lib/llvm-3.8/lib/'
" Auto generate tags file on file write of *.c and *.h files
autocmd BufWritePost *.c,*.h silent! !ctags . &

let g:jedi#popup_on_dot = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      File specific 		                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType tex set spell
