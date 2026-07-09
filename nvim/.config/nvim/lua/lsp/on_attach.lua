local buf_map = require('helpers').buf_map
local buf_option = require('helpers').buf_option

local on_attach = function(client, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local opts = { noremap = true, silent = true, buffer = bufnr }

  buf_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  buf_map('n', '<leader>dd', '<cmd>Lspsaga goto_definition<CR>', opts, 'LSP: Go to definition')
  buf_map(
    'n',
    '<leader>df',
    '<cmd>lua vim.lsp.buf.implementation()<CR>',
    opts,
    'LSP: Go to implementation'
  )
  buf_map(
    'n',
    '<leader>dt',
    '<cmd>lua vim.lsp.buf.type_definition()<CR>',
    opts,
    'LSP: Go to type definition'
  )
  buf_map('n', '<leader>dr', '<cmd>lua vim.lsp.buf.references()<CR>', opts, 'LSP: List references')
  buf_map('n', '<leader>drr', [[<cmd>Lspsaga rename<CR>]], opts, 'LSP: Rename symbol')
  buf_map('n', '<leader>pd', '<cmd>Lspsaga peek_definition<CR>', opts, 'LSP: Peek definition')
  -- buf_map('n', '<leader>sh', '<cmd>Lspsaga signature_help<CR>', opts)
  buf_map('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts, 'LSP: Hover docs')
  buf_map(
    'n',
    '<leader>cs',
    '<cmd>Lspsaga show_line_diagnostics<CR>',
    opts,
    'LSP: Line diagnostics'
  )
  buf_map(
    'n',
    '<leader>dn',
    [[<cmd>lua require('lspsaga.diagnostic'):goto_next({ severity = { min=vim.diagnostic.severity.WARN } })<CR>]],
    opts,
    'LSP: Next diagnostic'
  )
  buf_map(
    'n',
    '<leader>dp',
    [[<cmd>lua require('lspsaga.diagnostic'):goto_prev({ severity = { min=vim.diagnostic.severity.WARN } })<CR>]],
    opts,
    'LSP: Previous diagnostic'
  )
  buf_map('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts, 'LSP: Code action')
  buf_map('v', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts, 'LSP: Code action')

  if client.supports_method('textDocument/formatting') then
    buf_map('n', '<leader>fo', '<cmd>lua vim.lsp.buf.format()<CR>', opts, 'LSP: Format buffer')
    buf_map(
      'v',
      '<leader>fo',
      '<cmd><C-U>lua vim.lsp.buf.format()<CR>',
      opts,
      'LSP: Format selection'
    )
  end
end

return on_attach
