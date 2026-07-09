local on_attach = require('lsp.on_attach')

local M = {}

-- Nearest ancestor with a TypeScript 7 install (aliased as
-- "typescript-7": "npm:typescript@^7" in package.json). The wrapper
-- bin execs the native tsgo binary, which serves LSP via --lsp --stdio.
M.find_root = function(path)
  for dir in vim.fs.parents(path) do
    if vim.uv.fs_stat(vim.fs.joinpath(dir, 'node_modules/typescript-7/bin/tsc')) then
      return dir
    end
  end
end

vim.lsp.config('tsgo', {
  cmd = function(dispatchers, config)
    local bin = vim.fs.joinpath(config.root_dir, 'node_modules/typescript-7/bin/tsc')
    return vim.lsp.rpc.start({ bin, '--lsp', '--stdio' }, dispatchers)
  end,
  root_dir = function(bufnr, on_dir)
    local root = M.find_root(vim.api.nvim_buf_get_name(bufnr))
    if root then
      on_dir(root)
    end
  end,
  on_attach = on_attach,
})

vim.lsp.enable('tsgo')

return M
