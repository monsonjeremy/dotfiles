local on_attach = require('lsp.on_attach')

return {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    if client.config.flags then client.config.flags.allow_incremental_sync = true end
    require('lsp_signature').on_attach({ use_lspsaga = true })
    on_attach(client)
  end,
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
}
