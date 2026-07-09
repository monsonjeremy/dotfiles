local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')

vim.lsp.config('dockerls', {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    on_attach(client)
  end,
})
