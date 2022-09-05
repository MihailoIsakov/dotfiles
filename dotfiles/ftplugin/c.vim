" Ctags setup
let g:clang_library_path='/usr/lib/llvm-3.8/lib/'
" Auto generate tags file on file write of *.c and *.h files
autocmd BufWritePost *.c,*.h silent! !ctags . &
