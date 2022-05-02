local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.cssls.setup({
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    on_attach(client)
  end,
  capabilities = capabilities,
  filetypes = { 'css', 'scss' },
})
