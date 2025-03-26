local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')

lspconfig.terraform_lsp.setup({
  on_attach = function(client)
    client.server_capabilities.signature_help = false
    on_attach(client)
  end,
  filetypes = { 'terraform', 'tf' },
})
