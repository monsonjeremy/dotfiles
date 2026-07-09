return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 1000,
          })
        end,
        mode = { 'n', 'v' },
        desc = 'Format file or range (in visual mode)',
      },
    },
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          javascript = { 'prettierd', 'prettier', stop_after_first = true },
          typescript = { 'prettierd', 'prettier', stop_after_first = true },
          javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
          typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
          svelte = { 'prettierd', 'prettier', stop_after_first = true },
          css = { 'prettierd', 'prettier', stop_after_first = true },
          html = { 'prettierd', 'prettier', stop_after_first = true },
          json = { 'prettierd', 'prettier', stop_after_first = true },
          yaml = { 'prettierd', 'prettier', stop_after_first = true },
          markdown = { 'prettierd', 'prettier', stop_after_first = true },
          graphql = { 'prettierd', 'prettier', stop_after_first = true },
          lua = { 'stylua' },
          python = { 'isort', 'black' },
          go = { 'goimports', 'gofmt' },
          rust = { 'rustfmt' },
          elixir = { 'mix' },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        },
      })
    end,
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      {
        '<leader>l',
        function()
          require('lint').try_lint()
        end,
        desc = 'Trigger linting for current file',
      },
    },
    config = function()
      local lint = require('lint')

      lint.linters_by_ft = {
        python = { 'pylint' },
        dockerfile = { 'hadolint' },
        json = { 'jsonlint' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
