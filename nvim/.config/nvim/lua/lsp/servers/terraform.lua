local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').default_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

lspconfig.terraform_lsp.setup({
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.signature_help = false
    on_attach(client)
  end,
  filetypes = { 'terraform', 'tf' },
})
