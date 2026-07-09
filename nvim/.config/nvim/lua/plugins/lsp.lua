return {
  {
    'nvimdev/lspsaga.nvim',
    branch = 'main',
    event = 'LspAttach',
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    config = function()
      require('lspsaga').setup({
        lightbulb = { enable = false },
        ui = {
          title = true,
          border = 'rounded',
          colors = require('catppuccin.groups.integrations.lsp_saga').custom_colors(),
          kind = require('catppuccin.groups.integrations.lsp_saga').custom_kind(),
        },
      })
    end,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'zbirenbaum/copilot-cmp',
    event = 'InsertEnter',
    config = function()
      require('copilot_cmp').setup()
    end,
    dependencies = { 'zbirenbaum/copilot.lua' },
  },
  {
    'mason-org/mason.nvim',
    build = ':MasonUpdate',
  },
  'mason-org/mason-lspconfig.nvim',
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
    config = function()
      local default_publish_diagnostics = vim.lsp.handlers['textDocument/publishDiagnostics']

      require('typescript-tools').setup({
        on_attach = function(client, bufnr)
          if
            vim.fs.find({ 'deno.json', 'deno.jsonc' }, { path = vim.fn.getcwd(), upward = true })[1]
          then
            client.stop()
            return
          end
          -- TypeScript 7 projects use tsgo (lsp/servers/tsgo.lua) instead
          if require('lsp.servers.tsgo').find_root(vim.api.nvim_buf_get_name(bufnr)) then
            client.stop()
            return
          end
          require('lsp.on_attach')(client, bufnr)
        end,
        settings = {
          separate_diagnostic_server = false,
          tsserver_plugins = {},
        },
        handlers = {
          ['textDocument/publishDiagnostics'] = function(err, result, ctx, config)
            if not result or result.diagnostics == nil then
              if default_publish_diagnostics then
                return default_publish_diagnostics(err, result, ctx, config)
              end
              return
            end

            -- Filter diagnostics
            local idx = 1
            while idx <= #result.diagnostics do
              local entry = result.diagnostics[idx]
              local formatter = require('format-ts-errors')[entry.code]
              entry.message = formatter and formatter(entry.message) or entry.message

              if entry.code == 80001 then
                table.remove(result.diagnostics, idx)
              else
                idx = idx + 1
              end
            end
            if default_publish_diagnostics then
              return default_publish_diagnostics(err, result, ctx, config)
            end
          end,
        },
      })
    end,
  },
  { 'nvim-lua/lsp_extensions.nvim', ft = 'rust' },
  {
    'onsails/lspkind-nvim',
    event = 'InsertEnter',
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('lsp')
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'copilot' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        }),
      })
    end,
  },
}
