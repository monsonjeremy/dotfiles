local lsp = vim.lsp

require('lsp.servers.bash')
require('lsp.servers.css')
require('lsp.servers.html')
require('lsp.servers.json')
require('lsp.servers.lua')
require('lsp.servers.rust')
require('lsp.servers.ts')
require('lsp.servers.vim')
require('lsp.servers.efm')

local function set_sign(type, icon)
  local sign = string.format("LspDiagnosticsSign%s", type)
  local texthl = string.format("LspDiagnosticsDefault%s", type)
  vim.fn.sign_define(sign, {text = icon, texthl = texthl})
end

set_sign("Hint", "")
set_sign("Information", "")
set_sign("Warning", " ")
set_sign("Error", "ﰸ")


lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(
  lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      underline = true,
      prefix = "●",
      spacing = 2,
      signs = {
        severity_limit = "Warning",
      }
    },
  }
)
