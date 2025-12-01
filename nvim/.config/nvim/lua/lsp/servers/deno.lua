local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')

vim.lsp.config('denols', {
  root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc', 'import_map.json'),
  on_attach = function(client)
    client.server_capabilities.document_formatting = true
    on_attach(client)
  end,
})
