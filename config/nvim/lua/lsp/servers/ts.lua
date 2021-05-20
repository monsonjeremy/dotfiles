local lsp_config = require('lspconfig')
local on_attach = require('lsp.on_attach')

lsp_config.tsserver.setup({
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end
    require "lsp_signature".on_attach()
    on_attach(client)
  end,
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
})
