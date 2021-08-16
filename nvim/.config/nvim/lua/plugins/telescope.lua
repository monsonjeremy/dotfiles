local map = require('utils').map
local opts = { noremap = true, silent = true }

require('telescope').setup({
  defaults = {
    vimgrep_arguments = {
      'rg', '--color=never', '--no-heading', '--with-filename', '--line-number',
      '--column', '--smart-case', '--hidden',
    }, prompt_prefix = '🔍 ', layout_config = { prompt_position = 'top' },
    sorting_strategy = 'ascending',
    file_ignore_patterns = { 'node_modules', '.git/', 'terraform.tfstate' },
  },
})

map('n', '<C-p>', [[:Telescope find_files hidden=true<CR>]], opts)
map('n', '<leader>p', [[:Telescope buffers <CR>]], opts)
map('n', '<leader>ff', [[:Telescope live_grep<CR>]], opts)
