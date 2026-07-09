local shared = require('config.keymaps.shared')
local map = shared.map
local opts = shared.opts

map('n', '<Space>', [[<Nop>]], opts, 'Leader key placeholder')
map('n', '<C-s>', [[ <Cmd> w <CR>]], opts, 'Save file')
map('n', '<leader>ps', [[<Cmd>LazySync<CR>]], opts, 'Sync plugins')
map('n', '<leader>ve', [[:vsplit $MYVIMRC<CR>]], opts, 'Open vimrc in vertical split')
map('n', '<leader>q', [[ZZ<C-w><C-p>]], opts, 'Save and close window')
map('n', '<leader>e', [[:e<CR>]], opts, 'Reload current buffer')
map('n', '<Esc>', [[:nohlsearch<CR>]], opts, 'Clear search highlight')
map('n', '<C-_>', [[:nohlsearch<CR>]], opts, 'Clear search highlight')
