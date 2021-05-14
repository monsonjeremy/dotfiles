local lsp = vim.lsp

lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(
  lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    -- virtual_text = {
    --   -- prefix = "●",
    --   -- spacing = 4,
    --   severity_limit = "Warning",
    -- },
    -- signs = true
  }
)

local function set_sign(type, icon)
  local sign = string.format("LspDiagnosticsSign%s", type)
  local texthl = string.format("LspDiagnosticsDefault%s", type)
  vim.fn.sign_define(sign, {text = icon, texthl = texthl})
end

set_sign("Hint", "")
set_sign("Information", "")
set_sign("Warning", " ")
set_sign("Error", "ﰸ")

require('lsp.servers.bash')
require('lsp.servers.css')
require('lsp.servers.efm')
require('lsp.servers.html')
require('lsp.servers.json')
require('lsp.servers.lua')
require('lsp.servers.rust')
require('lsp.servers.ts')
require('lsp.servers.vim')
