local on_attach = require('lsp.on_attach')

return {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
    vim.cmd([[autocmd BufWritePre <buffer> <cmd>EslintFixAll<CR>]])
    on_attach(client)
  end,
  filetypes = { 'css', 'less', 'scss', 'sass', 'stylus', 'postcss' },
  settings = {
    stylelintplus = {
      autoFixOnSave = true,
      autoFixOnFormat = true,
      configFile = vim.fn.expand('~/dotfiles/stylua.toml'),
    },
  },
}
