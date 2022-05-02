local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')

lspconfig.rust_analyzer.setup({ on_attach = on_attach })
