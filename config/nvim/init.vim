if !exists('g:vscode')
  " Use space as Leader key (default).
  "let g:mapleader="\<Space>"
  let g:mapleader=" "
  let maplocalleader = "ﬁ"

  scriptencoding utf-8

  source $HOME/.config/nvim/functions.vim
  source $HOME/.config/nvim/commands.vim

  " Plugins
  source $HOME/.config/nvim/plugins.vim
  source $HOME/.config/nvim/config.vim
  source $HOME/.config/nvim/fzf.vim

  source $HOME/.config/nvim/macros.vim
  source $HOME/.config/nvim/keymap.vim
endif
