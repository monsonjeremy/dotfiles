if !exists('g:vscode')
  " Use space as Leader key (default).
  let g:mapleader=" "
  set fillchars=eob:\ ,

  scriptencoding utf-8

  source $HOME/.config/nvim/functions.vim

  lua require("init")

  source $HOME/.config/nvim/config.vim
  source $HOME/.config/nvim/keymap.vim
endif
