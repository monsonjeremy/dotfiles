local on_attach = require('lsp.on_attach')

-- Helper function to fix all eslint issues
local function eslint_fix_all(bufnr)
  local params = {
    command = 'eslint.applyAllFixes',
    arguments = {
      {
        uri = vim.uri_from_bufnr(bufnr),
        version = vim.lsp.util.buf_versions[bufnr],
      },
    },
  }
  vim.lsp.buf_request_sync(bufnr, 'workspace/executeCommand', params, 500)
end

vim.lsp.config('eslint', {
  root_dir = function(bufnr, on_dir)
    local filepath = vim.api.nvim_buf_get_name(bufnr)

    if filepath == '' then
      return
    end

    local found = vim.fs.find('package.json', {
      upward = true,
      path = vim.fs.dirname(filepath),
      stop = vim.env.HOME,
    })[1]

    local root = found and vim.fs.dirname(found) or vim.fs.dirname(filepath)

    on_dir(root)
  end,
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'EslintFixAll', function()
      eslint_fix_all(bufnr)
    end, { desc = 'Fix all eslint problems' })

    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        eslint_fix_all(bufnr)
      end,
    })

    on_attach(client, bufnr)
  end,
  settings = {
    workingDirectory = {
      mode = 'location',
    },
    experimental = { useFlatConfig = false },
  },
})
