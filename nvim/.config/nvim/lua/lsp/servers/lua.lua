local lspconfig = require('lspconfig')

lspconfig.sumneko_lua.setup(require('lua-dev').setup({
  plugins = true,
  lspconfig = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
      },
    },
  },
}))
