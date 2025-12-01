local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')

vim.lsp.config('elixirls', {
  on_attach = function(client)
    client.server_capabilities.document_formatting = true
    on_attach(client)
  end,
  cmd = { 'elixir-ls' },
  settings = {
    elixirLS = {
      -- I choose to disable dialyzer for personal reasons, but
      -- I would suggest you also disable it unless you are well
      -- aquainted with dialzyer and know how to use it.
      dialyzerEnabled = false,
      -- I also choose to turn off the auto dep fetching feature.
      -- It often get's into a weird state that requires deleting
      -- the .elixir_ls directory and restarting your editor.
      fetchDeps = false,
    },
  },
})
