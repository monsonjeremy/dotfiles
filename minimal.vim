call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'nvim-lua/plenary.nvim'

call plug#end()

lua << EOF
EOF
