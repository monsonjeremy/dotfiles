local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')

vim.lsp.config('vimls', { on_attach = on_attach })
