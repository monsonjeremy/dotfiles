local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')

vim.lsp.config('html', {
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    on_attach(client)
  end,
  filetypes = { 'html', 'svelte' },
})
