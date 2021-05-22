local map = require('utils').map

local opts = {
  noremap = true,
  silent = true
}

map("n", "<Leader>sp", [[:lua require('spectre').open()<CR>]], opts)
map("n", "<Leader>spf", [[:lua require('spectre').open_file_search()<CR>]], opts)
map("v", "<Leader>sp", [[:lua require('spectre').open_visual()<CR>]], opts)
