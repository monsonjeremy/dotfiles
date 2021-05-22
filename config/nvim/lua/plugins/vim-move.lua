local map = require('utils').map

vim.g["move_map_keys"] = 0

map("v", "∆", [[<Plug>MoveBlockDown]], { noremap = false, silent = false })
map("v", "˚", [[<Plug>MoveBlockUp]], { noremap = false, silent = false })
map("n", "∆", [[<Plug>MoveLineDown]], { noremap = false, silent = false })
map("n", "˚", [[<Plug>MoveLineUp]], { noremap = false, silent = false })

