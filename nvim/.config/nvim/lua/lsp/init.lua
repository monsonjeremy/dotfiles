local present1 = pcall(require, 'lspconfig')
local present2, mason = pcall(require, 'mason')
local present3, masonAuto = pcall(require, 'mason-tool-installer')
if not (present1 or present2) then
  return
end

local lsp = vim.lsp
-- require('lsp.status')

mason.setup({
  -- automatic_installation = true,
})
masonAuto.setup({
  ensure_installed = {
    'bash-language-server',
    'css-lsp',
    'html-lsp',
    'json-lsp',
    'lua-language-server',
    'rust-analyzer',
    'typescript-language-server',
    'vim-language-server',
    'graphql-language-service-cli',
    'terraform-ls',
    'prisma-language-server',
    'elixir-ls',
    'dockerfile-language-server',
    'stylelint-lsp',
    'eslint-lsp',
    'cssmodules-language-server',
    'tailwindcss-language-server',
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
