local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')

lspconfig.cssls.setup({
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    on_attach(client)
  end,
  filetypes = { 'css', 'scss' },
  settings = {
    css = {
      lint = {
        unknownAtRules = 'ignore',
      },
    },
  },
})
