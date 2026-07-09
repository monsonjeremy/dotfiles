local shared = require('config.keymaps.shared')
local map = shared.map
local opts = shared.opts

map(
  'n',
  '<Leader>bs',
  [[/<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>]],
  'Search WORD under cursor'
)

map(
  'n',
  '<Leader>s',
  [[ :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left> ]],
  opts,
  'Substitute word under cursor'
)
map(
  'v',
  '<Leader>s',
  [[ :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left> ]],
  opts,
  'Substitute visual selection'
)

vim.keymap.set('n', '<leader>h', function()
  require('fff').find_files({ query = vim.fn.expand('<cword>') })
end, { desc = 'Smart picker', noremap = true, silent = true })

map('n', '<C-p>', '<cmd>FFFFind<CR>', opts, 'Find files')

vim.keymap.set('n', '<C-e>', function()
  require('snacks').picker.explorer({ hidden = true })
end, { desc = 'Explorer picker', noremap = true, silent = true })

vim.keymap.set('n', '<leader>p', function()
  require('snacks').picker.buffers()
end, { desc = 'Buffer picker', noremap = true, silent = true })

vim.keymap.set('n', '<leader>ff', function()
  require('fff').live_grep({
    grep = {
      modes = { 'plain' },
    },
  })
end, { desc = 'Grep with no regex and show hidden files', noremap = true, silent = true })

vim.keymap.set('n', '<leader>fg', function()
  require('fff').live_grep()
end, { desc = 'Grep', noremap = true, silent = true })

vim.keymap.set('n', '<leader>fb', function()
  require('snacks').picker.buffers()
end, { desc = 'Buffers', noremap = true, silent = true })

vim.keymap.set('n', '<leader>fh', function()
  require('snacks').picker.help()
end, { desc = 'Help Tags', noremap = true, silent = true })

map('n', '<Leader>sr', [[:GrugFar<CR>]], opts, 'Open GrugFar search and replace')

vim.keymap.set({ 'n', 'x' }, '<leader>sR', function()
  require('ssr').open()
end, { desc = 'Structural search and replace', noremap = true, silent = true })
