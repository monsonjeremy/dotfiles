local on_attach = require('lsp.on_attach')

return {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
    vim.cmd('autocmd BufWritePre <buffer> silent! <cmd>EslintFixAll<CR>')
    on_attach(client)
  end,
  settings = {
    format = { enable = true },
  },
}
