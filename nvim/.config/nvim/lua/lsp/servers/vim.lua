local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')

lspconfig.vimls.setup({ on_attach = on_attach })
