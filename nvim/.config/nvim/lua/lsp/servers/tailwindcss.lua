local on_attach = require('lsp.on_attach')

return {
  filetypes = {
    'djangohtml',
    'handlebars',
    'hbs',
    'html',
    'heex',
    'markdown',
    'mdx',
    'elixir',
    'css',
    'scss',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  init_options = {
    userLanguages = {
      ['phoenix-heex'] = 'html-eex',
      elixir = 'html-eex',
      heex = 'html-eex',
      eelixir = 'html-eex',
      eruby = 'erb',
    },
  },
}
