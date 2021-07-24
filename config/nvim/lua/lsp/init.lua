local map = require('utils').map

require('lsp.install')
require('lsp.servers')
require('lsp.completion')

local opts = {
  noremap = true,
  silent = true
}

map('n', '<leader>dd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
map('n', '<leader>df', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
map('n', '<leader>dt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
map('n', '<leader>dr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
map('n', '<leader>drr', '<cmd>Lspsaga rename<CR><CR>', opts)
map('n', '<leader>pd', '<cmd>Lspsaga preview_definition<CR>', opts)
map('n', '<leader>sh', '<cmd>Lspsaga signature_help<CR>', opts)
map('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
map('n', '<leader>cs', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
map('n', '<leader>dn', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
map('n', '<leader>dp', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
map('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts)
map('n', '<leader>fo', '<cmd>lua vim.lsp.buf.formatting_sync(nil, 1000)<CR>', opts)
map('v', '<leader>ca', '<cmd><C-U>Lspsaga range_code_action<CR>', opts)
