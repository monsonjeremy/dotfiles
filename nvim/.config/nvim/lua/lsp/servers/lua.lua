local on_attach = require('lsp.on_attach')

local path = vim.fn.expand('~')
local luadev = require('lua-dev').setup({
  lspconfig = {
    cmd = {
      path .. '/lua-language-server/bin/macOS/lua-language-server',
      '-E',
      path .. '/lua-language-server/main.lua',
    },
    on_attach = on_attach,
  },
})

return luadev
