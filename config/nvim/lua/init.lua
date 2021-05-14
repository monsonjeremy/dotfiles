require("config")
require('fileIcons')
require("git")
require("lsp")
require("treesitter")
require("tabline")
require("fileTree")

-- Plugins
require("trouble").setup({})
require("todo-comments").setup({})
require('lualine').setup({
  options = {
    theme = 'tokyonight',
  }
})

