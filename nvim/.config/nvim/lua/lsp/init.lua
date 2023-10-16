local present1, lspconfig = pcall(require, 'lspconfig')
local present2, mason = pcall(require, 'mason')
local present3, masonLSP = pcall(require, 'mason-lspconfig')
if not (present1 or present2 or present3) then
  return
end

local lsp = vim.lsp

mason.setup()
masonLSP.setup({
  ensure_installed = {
    'bashls',
    'cssls',
    'html',
    'jsonls',
    'lua_ls',
    'rust_analyzer',
    -- 'typescript-language-server',
    'vimls',
    'graphql',
    'terraformls',
    'tflint',
    'prismals',
    'elixirls',
    'dockerls',
    'stylelint_lsp',
    'eslint',
    'cssmodules_ls',
    'tailwindcss',
  },
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
