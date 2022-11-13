set spell

" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2

" Latex indenting 
set foldmethod=indent
"set wrap linebreak
set smartindent
set breakindent
set display+=lastline

" Do not wrap at 120 characters
"set tw=120
"set tw=0
set tw=80

" vimtex is slow, this may help?
" set nonumber
" set norelativenumber
" autocmd FileType tex :NoMatchParen
" au FileType tex setlocal nocursorline


"
" vimtex
"
let g:vimtex_view_method = 'zathura'
let maplocalleader = ","

" Setup Zathura inverse search according to https://ejmastnak.github.io/tutorials/vim-latex/pdf-reader.html
" This will only work if `vim --version` includes `+clientserver`!
if empty(v:servername) && exists('*remote_startserver')
  call remote_startserver('VIM')
endif

" Get Vim's window ID for switching focus from Zathura to Vim using xdotool.
" Only set this variable once for the current Vim instance.
if !exists("g:vim_window_id")
  let g:vim_window_id = system("xdotool getactivewindow")
endif

function! s:TexFocusVim() abort
  " Give window manager time to recognize focus moved to Zathura;
  " tweak the 200m as needed for your hardware and window manager.
  sleep 100m

  " Refocus Vim and redraw the screen
  silent execute "!xdotool windowfocus " . expand(g:vim_window_id)
  redraw!
endfunction

augroup vimtex_event_focus
  au!
  au User VimtexEventView call s:TexFocusVim()
augroup END

"   " This is necessary for VimTeX to load properly. The "indent" is optional.
"   " Note that most plugin managers will do this automatically.
"   filetype plugin indent on
"
"   " This enables Vim's and neovim's syntax-related features. Without this, some
"   " VimTeX features will not work (see ":help vimtex-requirements" for more
"   " info).
"   " syntax enable
"
"   " Viewer options: One may configure the viewer either by specifying a built-in
"   " viewer method:
"   let g:vimtex_view_method = 'zathura'
"
"   " Or with a generic interface:
"   " let g:vimtex_view_general_viewer = 'okular'
"   " let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
"
"   " VimTeX uses latexmk as the default compiler backend. If you use it, which is
"   " strongly recommended, you probably don't need to configure anything. If you
"   " want another compiler backend, you can change it as follows. The list of
"   " supported backends and further explanation is provided in the documentation,
"   " see ":help vimtex-compiler".
"   " let g:vimtex_compiler_method = 'latexrun'
"   " let g:vimtex_compiler_method = './latexmk.sh'
"
"   " Most VimTeX mappings rely on localleader and this can be changed with the
"   " following line. The default is usually fine and is the symbol "\".
"   let maplocalleader = ","
"
"   " Taken from https://castel.dev/post/lecture-notes-1/
"   let g:tex_flavor='latex'
"   let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=0
let g:tex_conceal='abdmg'

" conceal background color
hi Conceal ctermfg=NONE guifg=NONE ctermbg=NONE guibg=NONE


"
" Goyo + Limelight
"
map <C-g> :Goyo<CR>
highlight Normal ctermbg = 235 
highlight nonText ctermbg = 235
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Color name (:help cterm-colors) or ANSI code
"let g:limelight_conceal_ctermfg = 'gray'
"let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
" let g:limelight_conceal_guifg = 'DarkGray'
" let g:limelight_conceal_guifg = '#777777'

" default: 0.5
let g:limelight_default_coefficient = 0.8

" Number of preceding/following paragraphs to include (default: 0)
"let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
"let g:limelight_bop = '^\s'
"let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
"let g:limelight_priority = -1


"
" latex-unicoder
"
" let g:unicoder_cancel_normal = 1
" let g:unicoder_cancel_insert = 1
" let g:unicoder_cancel_visual = 1
" nnoremap <C-l> :call unicoder#start(0)<CR>
" inoremap <C-l> <Esc>:call unicoder#start(1)<CR>
" vnoremap <C-l> :<C-u>call unicoder#selection()<CR>

" let g:unicoder_no_map = 1
" map <C-l> <Plug>Unicoder


