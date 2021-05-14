local cmd = vim.cmd
vim.g.tokyonight_style = "storm"
vim.g.tokyonight_italic_functions = true

cmd "syntax on"
cmd "set background=dark"
cmd "set cursorline"
cmd "set termguicolors"
cmd "colorscheme tokyonight"

require('colorizer').setup()
