local lspconfig = require('lspconfig')

require('neodev').setup({})

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
      },
    },
  },
})
