local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')

vim.lsp.config('prismals', {
  on_attach = function(client)
    client.server_capabilities.document_formatting = true
    on_attach(client)
  end,
})
