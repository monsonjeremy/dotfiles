local buf_map = require('helpers').buf_map
local buf_option = require('helpers').buf_option

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == 'null-ls'
    end,
    bufnr = bufnr,
  })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local on_attach = function(client)
  local opts = { noremap = true, silent = true }

  buf_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  buf_map('n', '<leader>dd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_map('n', '<leader>df', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_map('n', '<leader>dt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_map('n', '<leader>dr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_map('n', '<leader>drr', [[<cmd>lua require('renamer').rename()<cr>]], opts)
  buf_map('n', '<leader>pd', '<cmd>Lspsaga preview_definition<CR>', opts)
  buf_map('n', '<leader>sh', '<cmd>Lspsaga signature_help<CR>', opts)
  buf_map('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
  buf_map('n', '<leader>cs', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
  buf_map(
    'n',
    '<leader>dn',
    [[<cmd>lua require('lspsaga.diagnostic').goto_next({ severity = { min=vim.diagnostic.severity.WARN } })<CR>]],
    opts
  )
  buf_map(
    'n',
    '<leader>dp',
    [[<cmd>lua require('lspsaga.diagnostic').goto_prev({ severity = { min=vim.diagnostic.severity.WARN } })<CR>]],
    opts
  )
  buf_map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_map('v', '<leader>ca', '<cmd><C-U>lua vim.lsp.buf.range_code_action()<CR>', opts)

  -- vim.cmd [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]
  if client.server_capabilities.signature_help then
    vim.cmd([[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]])
  end

  if client.supports_method('textDocument/formatting') then
    buf_map('n', '<leader>fo', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end

return on_attach
