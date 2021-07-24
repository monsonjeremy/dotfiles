local map = require('utils').map
local opts = {
  noremap = true,
  silent = true
}

require('hop').setup({})

map("n", "<leader>hw", [[:HopWord<cr>]], opts)
map("n", "<leader>h", [[:HopLine<cr>]], opts)

