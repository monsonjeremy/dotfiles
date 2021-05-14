local cmd = vim.cmd

cmd "syntax on"
cmd "set background=dark"
cmd "set cursorline"
cmd "set termguicolors"
cmd "colorscheme tokyonight"

require('colorizer').setup()
