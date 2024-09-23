local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')
local util = require('lspconfig/util')

lspconfig.eslint.setup({
  on_attach = function(client)
    client.server_capabilities.document_formatting = true
    vim.cmd('autocmd BufWritePre <buffer> silent! <cmd>EslintFixAll<CR>')
    on_attach(client)
  end,
  root_dir = util.root_pattern(
    '.eslintrc*',
    '.git',
    '.eslintrc.json',
    '.eslintrc',
    '.eslintrc.js',
    'node_modules'
  ),
  settings = {
    experimental = { useFlatConfig = false },
  },
})
