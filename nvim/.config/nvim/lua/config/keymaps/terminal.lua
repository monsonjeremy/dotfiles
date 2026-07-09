local shared = require('config.keymaps.shared')
local map = shared.map
local opts = shared.opts

map('t', '<Esc>', [[<C-\><C-n>]], opts, 'Exit terminal mode')
map('t', 'jj', [[<C-\><C-n>]], opts, 'Exit terminal mode')

vim.keymap.set('n', '<leader>tt', function()
  require('snacks').terminal()
end, { desc = 'Open terminal', noremap = true, silent = true })

vim.keymap.set(
  'n',
  '<leader>xp',
  'yy2o<ESC>kpV:!/bin/bash<CR>',
  { desc = 'Run current line as bash', noremap = true, silent = true }
)
vim.keymap.set(
  'v',
  '<leader>xp',
  'y\'<P\'<O<ESC>\'>o<ESC>:<C-u>\'<,\'>!/bin/bash<CR>',
  { desc = 'Run selection as bash', noremap = true, silent = true }
)
