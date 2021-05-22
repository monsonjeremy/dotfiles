local map = require('utils').map
local opts = {
  noremap = true,
  silent = true
}

require('telescope').setup({
  defaults = {
    prompt_position = "top",
    sorting_strategy = "ascending"
  }
})

map("n", "<C-p>", [[:Telescope find_files<CR>]], opts)
map("n", "<leader>p", [[:Telescope buffers <CR>]], opts)
map("n", "<leader>ff", [[:Telescope live_grep<CR>]], opts)
