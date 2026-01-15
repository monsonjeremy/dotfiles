local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')

vim.lsp.config('rust_analyzer', { on_attach = on_attach })
