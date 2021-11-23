local luadev = require('lua-dev').setup({
  plugins = true,
  lspconfig = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim', 'bufnr' },
        },
      },
    },
  },
})

return luadev
