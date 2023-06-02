local present1 = pcall(require, 'lspconfig')
local present2, lspinstall = pcall(require, 'nvim-lsp-installer')
if not (present1 or present2) then
  return
end

local lsp = vim.lsp
-- require('lsp.status')

lspinstall.setup({
  ensure_installed = {
    'bashls',
    'cssls',
    'html',
    'jsonls',
    'lua_ls',
    'rust_analyzer',
    'tsserver',
    'vimls',
    'graphql',
    'terraformls',
    'prismals',
    'elixirls',
    'dockerls',
    'stylelint_lsp',
    'eslint',
    'cssmodules_ls',
    'tailwindcss',
  },
  automatic_installation = true,
})

local function set_sign(type, icon)
  local sign = string.format('DiagnosticSign%s', type)
  local texthl = string.format('DiagnosticDefault%s', type)
  vim.fn.sign_define(sign, { text = icon, texthl = texthl })
end

set_sign('Hint', '')
set_sign('Information', '')
set_sign('Warning', '')
set_sign('Error', '⊗')

lsp.set_log_level('warn')

lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
  underline = { severity_limit = 'Warning' },
  virtual_text = { prefix = '●', spacing = 2, severity_limit = 'Warning' },
  signs = { severity_limit = 'Warning' },
})

require('lsp.servers')
