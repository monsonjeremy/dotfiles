local on_attach = require('lsp.on_attach')

return {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
    on_attach(client)
  end,
}
