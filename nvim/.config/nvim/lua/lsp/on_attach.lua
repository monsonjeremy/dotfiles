local buf_map = require('utils').buf_map
local buf_option = require('utils').buf_option

local on_attach = function(client)
  local opts = { noremap = true, silent = true }

  buf_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  buf_map('n', '<leader>dd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_map('n', '<leader>df', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_map('n', '<leader>dt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_map('n', '<leader>dr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_map('n', '<leader>drr', '<cmd>Lspsaga rename<CR><CR>', opts)
  buf_map('n', '<leader>pd', '<cmd>Lspsaga preview_definition<CR>', opts)
  buf_map('n', '<leader>sh', '<cmd>Lspsaga signature_help<CR>', opts)
  buf_map('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
  buf_map('n', '<leader>cs', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
  buf_map('n', '<leader>dn', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
  buf_map('n', '<leader>dp', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
  buf_map('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts)
  buf_map('v', '<leader>ca', '<cmd><C-U>Lspsaga range_code_action<CR>', opts)

  -- vim.cmd [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]
  vim.cmd([[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]])

  if client.resolved_capabilities.document_formatting then
    buf_map('n', '<leader>fo', '<cmd>lua vim.lsp.buf.formatting_sync(nil, 1000)<CR>', opts)
    buf_map('n', '<space>f', '<cmd>lua vim.lsp.buf.range_formatting_sync(nil, 1000)<CR>', opts)
    vim.api.nvim_exec(
      [[
      augroup Format
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
      augroup END
    ]],
      false
    )
  end
end

return on_attach
