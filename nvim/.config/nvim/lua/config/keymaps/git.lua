local shared = require('config.keymaps.shared')
local map = shared.map
local opts = shared.opts

map('n', '<leader>ga', [[:Git fetch --all<CR>]], opts, 'Git fetch all remotes')
map('n', '<leader>grum', [[:Git rebase upstream/main<CR>]], opts, 'Git rebase onto upstream/main')
map(
  'n',
  '<leader>grom',
  [[:Git rebase -i origin/main<CR>]],
  opts,
  'Git interactive rebase onto origin/main'
)
