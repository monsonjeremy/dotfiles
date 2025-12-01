local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')

vim.lsp.config('terraform_lsp', {
  on_attach = function(client)
    client.server_capabilities.signature_help = false
    on_attach(client)
  end,
  filetypes = { 'terraform', 'tf' },
})
