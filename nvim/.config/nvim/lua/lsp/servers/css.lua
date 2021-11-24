local on_attach = require('lsp.on_attach')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
  on_attach = function(client)
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    client.resolved_capabilities.document_formatting = false
    on_attach(client)
  end,
  capabilities = capabilities,
  filetypes = { 'css', 'scss' },
}
