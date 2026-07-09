local actions = require('config.actions')
local shared = require('config.keymaps.shared')
local map = shared.map
local opts = shared.opts

map('n', 'L', [[$]], opts, 'Move to end of line')
map('v', 'L', [[$]], opts, 'Move to end of line')
map('o', 'L', [[$]], opts, 'Move to end of line')

map('n', 'H', [[^]], opts, 'Move to start of line')
map('v', 'H', [[^]], opts, 'Move to start of line')
map('o', 'H', [[^]], opts, 'Move to start of line')

map('n', ',', [[<PageDown>]], opts, 'Page down')
map('n', '-', [[<PageUp>]], opts, 'Page up')

map('n', '<S-t>', [[<Cmd>tabnew<CR>]], opts, 'Open new tab')
map('n', '<S-x>', [[<Cmd>bdelete<CR>]], opts, 'Delete buffer')
map('n', '<TAB>', [[<Cmd>BufferLineCycleNext<CR>]], opts, 'Next buffer')
map('n', '<S-TAB>', [[<Cmd>BufferLineCyclePrev<CR>]], opts, 'Previous buffer')

map('n', '<Leader>n', [[:Neotree toggle<CR>]], opts, 'Toggle Neo-tree')
map('n', '<Leader>nr', [[:Neotree reveal<CR>]], opts, 'Reveal current file in Neo-tree')
map('n', '<Leader>np', [[:NoNeckPain<CR>]], opts, 'Toggle No Neck Pain')

map('n', '<C-h>', function()
  actions.move_window('h')
end, opts, 'Move to left split (create if missing)')
map('n', '<C-j>', function()
  actions.move_window('j')
end, opts, 'Move to lower split (create if missing)')
map('n', '<C-k>', function()
  actions.move_window('k')
end, opts, 'Move to upper split (create if missing)')
map('n', '<C-l>', function()
  actions.move_window('l')
end, opts, 'Move to right split (create if missing)')
