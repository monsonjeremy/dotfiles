local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')
local opts = { silent = true }

lspconfig.tsserver.setup({
  init_options = require('nvim-lsp-ts-utils').init_options,
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false

    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end

    require('lsp_signature').on_attach({ bind = true, use_lspsaga = true })

    local ts_utils = require('nvim-lsp-ts-utils')

    -- defaults
    ts_utils.setup({
      enable_import_on_completion = true,
      import_all_timeout = 5000,
      import_all_scan_buffers = 100,
      auto_inlay_hints = true,
      inlay_hints_highlight = 'Comment',
      inlay_hints_priority = 200, -- priority of the hint extmarks
      inlay_hints_throttle = 150, -- throttle the inlay hint request
    })

    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)

    -- no default maps, so you may want to define some here
    vim.api.nvim_buf_set_keymap(
      vim.api.nvim_get_current_buf(),
      'n',
      'gs',
      ':TSLspOrganize<CR>',
      opts
    )
    vim.api.nvim_buf_set_keymap(
      vim.api.nvim_get_current_buf(),
      'n',
      'gr',
      ':TSLspRenameFile<CR>',
      opts
    )
    vim.api.nvim_buf_set_keymap(
      vim.api.nvim_get_current_buf(),
      'n',
      'gi',
      ':TSLspImportAll<CR>',
      opts
    )

    on_attach(client)
  end,
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
})
