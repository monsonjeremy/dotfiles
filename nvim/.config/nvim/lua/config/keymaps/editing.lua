local actions = require('config.actions')
local shared = require('config.keymaps.shared')
local map = shared.map
local opts = shared.opts

map('v', 'X', [["_d]], 'Delete selection without yanking')

map(
  'n',
  '<Leader>ww',
  [[ const wait = (ms: number): Promise<void> => {<CR>return new]]
    .. [[Promise(res => setTimeout(res, ms));<CR>}<esc>k=i{<CR> ]],
  opts,
  'Insert wait helper snippet'
)
map(
  'n',
  '<Leader>ss',
  [[ O/** @type {sinon.SinonStub} */<esc><CR>]],
  opts,
  'Insert sinon stub annotation'
)

map('x', '@', function()
  actions.execute_macro_over_visual_range()
end, opts, 'Run macro over visual range')

map('n', 'c*', [[*``cgn]], opts, 'Change next match')
map('n', 'c#', [[*``cgN]], opts, 'Change previous match')
map('n', 'd*', [[*``dgn]], opts, 'Delete next match')
map('n', 'd#', [[*``dgN]], opts, 'Delete previous match')

map('v', '<leader>p', [["_dP]], opts, 'Paste without yanking replaced text')

map('n', '<leader>y', [["+y]], opts, 'Yank to system clipboard')
map('v', '<leader>y', [["+y]], opts, 'Yank selection to system clipboard')
map('n', '<leader>Y', [[gg"+yG]], opts, 'Yank entire buffer to clipboard')

map('n', '<leader>d', [[_d]], opts, 'Delete without yanking')
map('v', '<leader>d', [[_d]], opts, 'Delete selection without yanking')

map('n', '∆', ':MoveLine(1)<CR>', opts, 'Move line down')
map('n', '˚', ':MoveLine(-1)<CR>', opts, 'Move line up')
map('v', '∆', ':MoveBlock(1)<CR>', opts, 'Move selection down')
map('v', '˚', ':MoveBlock(-1)<CR>', opts, 'Move selection up')
