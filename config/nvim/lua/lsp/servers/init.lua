local lsp = vim.lsp

lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(
  lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
      prefix = "●",
      spacing = 4,
    },
    signs = true
  }
)

require('lsp.servers.bash')
require('lsp.servers.css')
require('lsp.servers.efm')
require('lsp.servers.html')
require('lsp.servers.json')
require('lsp.servers.lua')
require('lsp.servers.rust')
require('lsp.servers.ts')
require('lsp.servers.vim')
