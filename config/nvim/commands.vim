" Commands

" Auto reload vimrc
augroup autoreloadvimrc
  autocmd!
  autocmd BufWritePost *.vim source $MYVIMRC
augroup end
" }}}

" Terminal buffer
augroup terminal
  autocmd!
  autocmd TermOpen *
    \ setlocal nonumber |
    \ setlocal signcolumn=no
augroup end

