local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')

vim.lsp.config('bashls', { on_attach = on_attach })
