""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Text editing                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Start unwrapped                                                                                                       
set nowrap                                                                                                                                  
" Don't break lines                                                                                                     
"set textwidth=0                                                                                                         
"set wrapmargin=0  
"set nofixendofline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      Visuals / Theme                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
set relativenumber

" Syntax highlighting
syntax on

" Remove the default mode indicator because we have airline!
set noshowmode

" Switch buffers without saving
set hidden

" Theme settings
colorscheme molokai
"colorscheme gruvbox
" autocmd vimenter * ++nested colorscheme gruvbox
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE
" Airline theme to match
 let g:airline_theme = "luna"
"let g:airline_theme = "gruvbox"
let g:rehash256 = 1
set background=dark

" Airline tabs for open buffers -- Install tabline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

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
" Disable Background Color Erase (BCE) so that color schemes
" work properly when Vim is used inside tmux and GNU screen.
if &term =~ '256color'
    set t_ut=
endif

" Fold background color
hi Folded ctermbg=235

" Autocomplete background color
hi CocMenuSel ctermbg=yellow ctermfg=black

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
set iskeyword+=-

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

" Unmap help menu on F1
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

" Unmap ex mode
map Q <nop>

" Unmap mute key? 
noremap XF86AudioMute <nop>
noremap 121 <nop>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Low level behavior                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Timeout to Normal mode
set ttimeoutlen=50

" Reload .vimrc if changed
autocmd! bufwritepost .vimrc source %

" When exiting vim: 
"   1. Don't wipe clipboard when exiting vim 
"   2. Clear the terminal due to kitty terminal issues
autocmd VimLeave * call system('echo ' . shellescape(getreg('+')) .
            \ ' | xclip -selection clipboard;')

" Allow per-project .vimrc files 
set exrc
set secure 

" Undo folder
set undofile
set undodir=~/.vim/undodir


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Formatting                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic settings
filetype plugin indent on

" Tab settings
"set tabstop=4
"set shiftwidth=4
"set softtabstop=4
set expandtab

" Text width
"set tw=120

" Cursor settings
set cursorline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Search                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" * and # search for the word under the cursor, but not match substrings
" g* and g# do
map * g*``
map # g#``
map <C-f> *
map <C-c> :nohlsearch<CR>
" nnoremap <esc> <esc>:noh<CR>

" Case insensitive search by default
set ignorecase
set smartcase

" Higlight search matches
set hlsearch
" Turn off search highlight
" nnoremap <leader><space> :nohlsearch<CR>


" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
" nnoremap z\ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
" function! AutoHighlightToggle()
"    let @/ = ''
"    if exists('#auto_highlight')
"      au! auto_highlight
"      augroup! auto_highlight
"      setl updatetime=4000
"      echo 'Highlight current word: off'
"      return 0
"   else
"     augroup auto_highlight
"     au!
"     au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
"     augroup end
"     setl updatetime=500
"     echo 'Highlight current word: ON'
"   return 1
"  endif
" endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Plugins                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pathogen runtimepath management
execute pathogen#infect()
"execute pathogen#helptags()


"
" Ultisnips
"
let g:UltiSnipsExpandTrigger       = '<Tab>'    " use Tab to expand snippets
let g:UltiSnipsJumpForwardTrigger  = '<Tab>'    " use Tab to move forward through tabstops
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'  " use Shift-Tab to move backward through tabstops


" NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>

" Close NERDTree when opening a file
let g:NERDTreeQuitOnOpen = 1



" NERDCommenter
let g:NERDCreateDefaultMappings = 0
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1

nmap <leader>cc <plug>NERDCommenterInvert
xmap <leader>cc <plug>NERDCommenterInvert


" Gitgutter: 
let g:gitgutter_highlight_lines=0
set updatetime=100
let g:gitgutter_diff_args = '-w'
let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn
highlight GitGutterAdd ctermfg=2 
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1
highlight GitGutterChangeDelete ctermfg=4

" Vim airline word count
let g:airline#extensions#wordcount#enabled = 1
" Add notes to filetypes
let g:airline#extensions#wordcount#filetypes = '\vnotes|help|markdown|rst|org|text|asciidoc|tex|mail'

" recursively search up for tags file
set tags=tags;/

" Easymotion 
" map <Leader> <Plug>(easymotion-prefix)
nmap <C-s> <Plug>(easymotion-s)


" Incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)


" coc.vim
" Some servers have issues with backup files, see #649.
if !empty(glob("~/.vim/bundle/coc.nvim/"))
    set nobackup
    set nowritebackup
    
    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300
    
    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    set signcolumn=yes
    
    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
          \ coc#pum#visible() ? coc#pum#next(1):
          \ CheckBackspace() ? "\<Tab>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
    
    " Make <CR> to accept selected completion item or notify coc.nvim to format
    " <C-g>u breaks current undo, please make your own choice.
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    
    function! CheckBackspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
    
    " Use <c-space> to trigger completion.
    if has('nvim')
      inoremap <silent><expr> <c-space> coc#refresh()
    else
      inoremap <silent><expr> <c-@> coc#refresh()
    endif
    
    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)
    
    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    
    " Use K to show documentation in preview window.
    " nnoremap <silent> K :call ShowDocumentation()<CR>
    
    function! ShowDocumentation()
      if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
      else
        call feedkeys('K', 'in')
      endif
    endfunction
    
    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')
    
    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)
    
    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)
    
    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end
    
    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)
    
    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)
    
    " Run the Code Lens action on the current line.
    nmap <leader>cl  <Plug>(coc-codelens-action)
    
    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)
    
    " Remap <C-f> and <C-b> for scroll float windows/popups.
    " if has('nvim-0.4.0') || has('patch-8.2.0750')
    "   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    "   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    "   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    "   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    "   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    "   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    " endif
    
    " Use CTRL-S for selections ranges.
    " Requires 'textDocument/selectionRange' support of language server.
    " nmap <silent> <C-s> <Plug>(coc-range-select)
    " xmap <silent> <C-s> <Plug>(coc-range-select)
    
    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocActionAsync('format')
    
    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)
    
    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
    
    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
    
    " Mappings for CoCList
    " Show all diagnostics.
    " nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
    " " Manage extensions.
    " nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
    " " Show commands.
    " nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
    " " Find symbol of current document.
    " nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
    " " Search workspace symbols.
    " nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
    " " Do default action for next item.
    " nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
    " " Do default action for previous item.
    " nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
    " " Resume latest coc list.
    " nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
    
    " Adopted from https://github.com/wookayin/dotfiles/commit/c64b4f34c1f8051d4e0feb15eb3d4e57d7eab475
    " Experimental feature (preview definition): gp, `<leader>K`, or <Shift-F12>:
    " Peek into the definition in a floating window.
    " TODO: If there are 2+ definitions, it does not work with floating windows (coc.nvim problem)
    command! -nargs=0 PreviewDefinition :call CocActionAsync('jumpDefinition', ':OpenAsPreview')
    command! -nargs=* OpenAsPreview :call s:open_as_preview("<args>")
    function! s:open_as_preview(callstr)
      " e.g. the string should look like: +call cursor(<line>,<col>) <filename>
      let m = matchlist(a:callstr, '^+call cursor(\(\d\+\),\s*\(\d\+\))\s\+\(.*\)')
      if len(m) < 4   " TODO: more robust error handling
        echohl WarningMsg | echom "ERROR: Invalid callstr format" | echohl None
        return
      endif
      let linenr = m[1]
      let filename = expand(m[3])
      call quickui#preview#open(filename, {
            \ 'cursor': linenr,
            \ 'number' : 1,
            \ 'persist': 0,
            \ })
    endfunction
    " <F24> = <Shift-F12>
    nmap <F24>         :<C-U>PreviewDefinition<CR>
    nmap <leader>K     :<C-U>PreviewDefinition<CR>
    nmap <silent> gp   :<C-U>PreviewDefinition<CR>
endif


