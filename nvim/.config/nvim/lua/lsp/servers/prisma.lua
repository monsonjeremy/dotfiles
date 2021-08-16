local lsp_config = require('lspconfig')
local on_attach = require('lsp.on_attach')

lsp_config.prismals.setup({
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
    on_attach(client)
  end, cmd = { 'prisma-language-server', '--stdio' }, filetypes = { 'prisma' },
  root_dir = lsp_config.util.root_pattern('.git', 'package.json'),
  settings = { prisma = { prismaFmtBinPath = '' } },
})
