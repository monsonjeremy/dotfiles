local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')

lspconfig.eslint.setup({
  on_attach = function(client)
    client.server_capabilities.document_formatting = true
    vim.cmd('autocmd BufWritePre <buffer> silent! <cmd>EslintFixAll<CR>')
    on_attach(client)
  end,
  settings = {
    format = { enable = true },
  },
})
