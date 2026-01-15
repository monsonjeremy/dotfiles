local lspconfig = require('lspconfig')



vim.lsp.config('lua_ls', {
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
