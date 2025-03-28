local map = require('helpers').map

local g = vim.g
g.mapleader = ' '

local opts = { noremap = true, silent = true }

-- general
map('n', '<Leader>bs', [[/<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>]])
map('v', 'X', [["_d]])

-- save
map('n', '<C-s>', [[ <Cmd> w <CR>]], opts)
map(
  'n',
  '<Leader>ww',
  [[ const wait = (ms: number): Promise<void> => {<CR>return new]]
    .. [[Promise(res => setTimeout(res, ms));<CR>}<esc>k=i{<CR> ]],
  opts
)
map('n', '<Leader>ss', [[ O/** @type {sinon.SinonStub} */<esc><CR>]], opts)

-- Search and replace under cursor
map('n', '<Leader>s', [[ :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left> ]], opts)
map('v', '<Leader>s', [[ :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left> ]], opts)

-- === Search shorcuts === "
map('n', '<C-_>', [[:nohlsearch<CR>]], opts)

map('n', '<leader>ga', [[:Git fetch --all<CR>]], opts)
map('n', '<leader>grum', [[:Git rebase upstream/main<CR>]], opts)
map('n', '<leader>grom', [[:Git rebase -i origin/main<CR>]], opts)

map('n', '<leader>dg', ':lua require(\'neogen\').generate()<CR>', opts)
map('n', '<leader>ps', [[:Lazy sync<CR>]], opts)

map('n', '<Space>', [[<Nop>]], opts)
map('n', '<leader>ve', [[:vsplit $MYVIMRC<CR>]], opts)

-- Yank all matches
map('n', '<leader>Y', [[:CopyMatches<CR>]], opts)

-- Close and update buffer
map('n', '<leader>q', [[ZZ<C-w><C-p>]], opts)

map('n', '<leader>e', [[:e<CR>]], opts)

-- Escape to clear highlighting in normal mode
map('n', '<Esc>', [[:nohlsearch<CR>]], opts)

-- Macros
map('x', '@', [[:<C-u>call ExecuteMacroOverVisualRange()<CR>]], opts)

-- Movement
-- Move to end of line
map('n', 'L', [[$]], opts)
map('v', 'L', [[$]], opts)
map('o', 'L', [[$]], opts)

-- Move to start of line
map('n', 'H', [[^]], opts)
map('v', 'H', [[^]], opts)
map('o', 'H', [[^]], opts)

-- Terminal
-- Escape to exit to normal mode in terminal
map('t', '<Esc>', [[<C-\><C-n>]], opts)
map('t', 'jj', [[<C-\><C-n>]], opts)

-- Substitute
map('n', 'c*', [[*``cgn]], opts)
map('n', 'c#', [[*``cgN]], opts)
map('n', 'd*', [[*``dgn]], opts)
map('n', 'd#', [[*``dgN]], opts)

map('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Delete current visual selection and dump in black hole buffer before pasting
map('v', '<leader>p', [["_dP]], opts)

map('n', '<leader>y', [["+y]], opts)
map('v', '<leader>y', [["+y]], opts)

map('n', '<leader>Y', [[gg"+yG]], opts)

map('n', '<leader>d', [[_d]], opts)
map('v', '<leader>d', [[_d]], opts)
map('n', ',', [[<PageDown>]], opts)
map('n', '-', [[<PageUp>]], opts)

map('n', '<Leader>tt', [[:ToggleTerm<CR>]], opts)

-- Telescope
map('n', '<C-p>', [[:Telescope find_files hidden=true<CR>]], opts)
map('n', '<leader>p', [[:Telescope buffers <CR>]], opts)
map('n', '<leader>ff', [[:Telescope live_grep<CR>]], opts)

map('n', '<S-t>', [[<Cmd>tabnew<CR>]], opts)
map('n', '<S-x>', [[<Cmd>bdelete<CR>]], opts)
map('n', '<TAB>', [[<Cmd>BufferLineCycleNext<CR>]], opts)
map('n', '<S-TAB>', [[<Cmd>BufferLineCyclePrev<CR>]], opts)

map('n', '<Leader>sp', [[:lua require('spectre').open()<CR>]], opts)
map('n', '<Leader>so', [[:lua require('spectre').show_options()<CR>]], opts)
map('n', '<Leader>spf', [[:lua require('spectre').open_file_search()<CR>]], opts)
map('v', '<Leader>sp', [[:lua require('spectre').open_visual()<CR>]], opts)

map('n', '<Leader>n', [[:NvimTreeToggle<CR>]], opts)
map('n', '<Leader>r', [[:NvimTreeRefresh<CR>]], opts)
map('n', '<Leader>f', [[:NvimTreeFindFile<CR>]], opts)

map('n', '<Leader>np', [[:NoNeckPain<CR>]], opts)

map('n', '∆', ':MoveLine(1)<CR>', opts)
map('n', '˚', ':MoveLine(-1)<CR>', opts)
map('v', '∆', ':MoveBlock(1)<CR>', opts)
map('v', '˚', ':MoveBlock(-1)<CR>', opts)

map('n', '<C-h>', [[:call WinMove('h')<CR>]], opts)
map('n', '<C-j>', [[:call WinMove('j')<CR>]], opts)
map('n', '<C-k>', [[:call WinMove('k')<CR>]], opts)
map('n', '<C-l>', [[:call WinMove('l')<CR>]], opts)

map('n', '/', '<cmd>lua require("searchbox").incsearch()<CR>', opts)
map('n', '?', '<cmd>lua require("searchbox").incsearch({ reverse = true })<CR>', opts)

map(
  'v',
  '/',
  [[:<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0 | exec '/'.g:srchstr | endif<CR>]],
  opts
)
map(
  'v',
  '?',
  [[:<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0 | exec '?'.g:srchstr | endif<CR>]],
  opts
)

vim.keymap.set({ 'n', 'x' }, '<leader>sr', function()
  require('ssr').open()
end)

vim.keymap.set('n', '<leader>xp', 'yy2o<ESC>kpV:!/bin/bash<CR>')
vim.keymap.set('v', '<leader>xp', 'y\'<P\'<O<ESC>\'>o<ESC>:<C-u>\'<,\'>!/bin/bash<CR>')
