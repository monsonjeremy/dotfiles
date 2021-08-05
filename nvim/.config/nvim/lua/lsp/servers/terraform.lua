local on_attach = require('lsp.on_attach')

return {
  on_attach = on_attach,
  filetypes = {
    'terraform',
    'tf',
  },
}
