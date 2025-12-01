local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')

vim.lsp.config('cssmodules_ls', {
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    on_attach(client)
  end,
})
