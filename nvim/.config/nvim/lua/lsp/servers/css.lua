local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').default_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.cssls.setup({
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    on_attach(client)
  end,
  capabilities = capabilities,
  filetypes = { 'css', 'scss' },
  settings = {
    css = {
      lint = {
        unknownAtRules = 'ignore',
      },
    },
  },
})
