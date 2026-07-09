vim.lsp.config('graphql', {
  handlers = {
    ['textDocument/publishDiagnostics'] = function() end,
  },
})
