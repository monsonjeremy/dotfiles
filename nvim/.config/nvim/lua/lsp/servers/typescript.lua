local on_attach = require('lsp.on_attach')
local opts = { silent = true }

return {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end

    require('lsp_signature').on_attach({ bind = true, use_lspsaga = true })

    local ts_utils = require('nvim-lsp-ts-utils')

    -- defaults
    ts_utils.setup({
      debug = true,
      enable_import_on_completion = true,
      import_all_timeout = 5000,
      import_all_scan_buffers = 100,
      eslint_enable_code_actions = true,
      eslint_enable_disable_comments = true,
      eslint_bin = 'eslint_d',
      eslint_enable_diagnostics = true,
      eslint_diagnostics_debounce = 250,
      eslint_opts = {
        args = {
          '-f',
          'json',
          '--stdin',
          '--stdin-filename',
          '$FILENAME',
        },
        diagnostics_format = '#{m} [#{c}]',
      },

      enable_formatting = true,
      formatter = 'eslint_d',
      format_on_save = true,
      formatter_opts = {
        '--fix-to-stdout',
        '--stdin',
        '--stdin-filename',
        '$FILENAME',
      },
      update_imports_on_move = true,
      require_confirmation_on_move = true,
    })

    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)

    -- no default maps, so you may want to define some here
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', ':TSLspOrganize<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', ':TSLspRenameFile<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', ':TSLspImportAll<CR>', opts)

    on_attach(client)
  end,
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
}
