call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'windwp/nvim-spectre'

call plug#end()

nnoremap <leader>S :lua require('spectre').open()<CR>

nnoremap <leader>sw viw:lua require('spectre').open_visual()<CR>
vnoremap <leader>s :lua require('spectre').open_visual()<CR>
nnoremap <leader>sp viw:lua require('spectre').open_file_search()<cr>

lua << EOF
  _G.__is_log =true
  require('spectre').setup()
EOF
