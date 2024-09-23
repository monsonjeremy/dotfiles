require('lazy').setup({
  {
    'VonHeikemen/searchbox.nvim',
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
    },
  },
  {
    'luckasRanarison/nvim-devdocs',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('plugins.lualine')
    end,
  },
  {
    'luukvbaal/stabilize.nvim',
    config = function()
      require('stabilize').setup()
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
    event = 'BufRead',
    config = function()
      require('plugins.indentline')
    end,
  },
  {
    'mistricky/codesnap.nvim',
    build = 'make',
    config = function()
      require('codesnap').setup({
        has_breadcrumbs = true,
      })
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,

    config = function()
      require('plugins.catppuccin-config')
    end,
  },
  {
    'nvim-tree/nvim-web-devicons',
    event = 'BufRead',
    config = function()
      require('plugins.nvim-web-devicons')
    end,
  },

  {
    'gpanders/editorconfig.nvim',
    event = 'BufRead',
  },

  {
    'folke/noice.nvim',
    event = 'VimEnter',
    config = function()
      require('noice').setup({
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        lsp = {
          override = {
            -- ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
          },
          progress = {
            view = 'notify',
          },
        },
        views = {
          notify = { merge = true, replace = true, title = 'LSP' },
        },
      })
    end,
    dependencies = {
      -- 'MunifTanjim/nui.nvim',
      {
        'rcarriga/nvim-notify',
        config = function()
          require('plugins.notify')
        end,
      },
    },
  },

  -- {
  --   'github/copilot.vim',
  --   event = 'InsertEnter',
  -- },

  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'VimEnter',
    config = function()
      vim.defer_fn(function()
        require('copilot').setup({
          suggestion = {
            enabled = false,
            -- enabled = true,
            -- auto_trigger = true,
            -- debounce = 75,
            -- keymap = {
            --   accept = '<Tab>',
            --   accept_word = false,
            --   accept_line = false,
            --   next = '<C-]>',
            --   prev = '<C-[>',
            --   dismiss = '<C-e>',
            -- },
          },
          panel = { enabled = false },
        })
      end, 100)
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    opts = {
      -- See Configuration section for rest
    },
  },

  {
    'zbirenbaum/copilot-cmp',
    commit = 'c2cdb3c0f5078b0619055af192295830a7987790',
    -- after = { 'copilot.lua' },
    config = function()
      require('copilot_cmp').setup()
    end,
  },

  -- LSP
  {
    'nvimdev/lspsaga.nvim',
    branch = 'main',
    event = 'BufRead',
    config = function()
      require('lspsaga').setup({
        ui = {
          -- theme = 'round',
          title = true,
          border = 'rounded',
          colors = require('catppuccin.groups.integrations.lsp_saga').custom_colors(),
          kind = require('catppuccin.groups.integrations.lsp_saga').custom_kind(),
        },
      })
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
  -- { 'ray-x/lsp_signature.nvim', event = 'BufRead' },
  { 'folke/neodev.nvim' },
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate', -- :MasonUpdate updates registry contents
  },
  'williamboman/mason-lspconfig.nvim',
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
    config = function()
      require('typescript-tools').setup({
        on_attach = function(client)
          if require('lspconfig').util.root_pattern('deno.json', 'deno.jsonc')(vim.fn.getcwd()) then
            client.stop()
            return
          end
        end,
        settings = {
          separate_diagnostic_server = true,
          tsserver_plugins = {},
        },
      })
    end,
  },
  { 'nvim-lua/lsp_extensions.nvim', event = 'BufRead' },
  {
    'ojroques/nvim-lspfuzzy',
    dependencies = {
      { 'junegunn/fzf', event = 'BufRead' },
      { 'junegunn/fzf.vim', event = 'BufRead' },
    },
    event = 'BufRead',
    config = function()
      require('lspfuzzy').setup({})
    end,
  },
  {
    'folke/trouble.nvim',
    event = 'BufRead',
    -- after = 'nvim-web-devicons',
    config = function()
      require('trouble').setup({})
    end,
  },
  {
    'cshuaimin/ssr.nvim',
    -- module = 'ssr',
  },
  {
    'onsails/lspkind-nvim',
    event = 'BufRead',
    -- module = 'lspkind',
  },
  {
    'elixir-tools/elixir-tools.nvim',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local elixir = require('elixir')
      local elixirls = require('elixir.elixirls')

      elixir.setup({
        nextls = { enable = true },
        credo = {},
        elixirls = {
          enable = true,
          settings = elixirls.settings({
            dialyzerEnabled = false,
            enableTestLenses = false,
          }),
          on_attach = function(client, bufnr)
            vim.keymap.set(
              'n',
              '<space>fp',
              ':ElixirFromPipe<cr>',
              { buffer = true, noremap = true }
            )
            vim.keymap.set('n', '<space>tp', ':ElixirToPipe<cr>', { buffer = true, noremap = true })
            vim.keymap.set(
              'v',
              '<space>em',
              ':ElixirExpandMacro<cr>',
              { buffer = true, noremap = true }
            )
          end,
        },
      })
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('lsp')
    end,
    -- after = {
    --   'cmp',
    --   'cmp-nvim-lsp',
    --   'nvim-lsp-installer',
    --   'lspsaga.nvim',
    --   -- 'lsp_signature.nvim',
    --   'neodev.nvim',
    --   'lsp_extensions.nvim',
    --   'nvim-lspfuzzy',
    --   'trouble.nvim',
    --   'lspkind-nvim',
    -- },
  },

  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'gbprod/none-ls-luacheck.nvim',
    },
  },

  {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    -- after = 'nvim-lspconfig',
    -- module = 'nvim-lsp-ts-utils',
  },

  {
    'simrat39/rust-tools.nvim',
    ft = 'rs',
    config = function()
      require('rust-tools').setup()
    end,
  },

  -- Terminal
  {
    'akinsho/nvim-toggleterm.lua',
    branch = 'main',
    cmd = 'ToggleTerm',
    config = function()
      require('plugins.toggleterm')
    end,
  },

  -- Navigation / Helpers
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },
  { 'nvim-lua/plenary.nvim' },
  {
    'nvim-lua/popup.nvim',
    -- after = 'plenary.nvim'
  },

  { 'nanotee/zoxide.vim' },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
    event = 'BufRead',
  },
  {
    'echasnovski/mini.nvim',
    version = '*',
    event = 'BufRead',
    config = function()
      require('mini.surround').setup({})
      require('mini.ai').setup({})
      require('mini.cursorword').setup({})
    end,
  },
  { 'tpope/vim-repeat', keys = { '.', mode = 'n' } },
  { 'chaoren/vim-wordmotion', event = 'BufRead' },
  { 'tweekmonster/startuptime.vim', cmd = 'StartupTime' },
  {
    'fedepujol/move.nvim',
    cmd = { 'MoveLine', 'MoveBlock' },
    config = function()
      require('move').setup()
    end,
  },
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('plugins.dashboard')
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },

  {
    'windwp/nvim-spectre',
    -- module = 'spectre',
    config = function()
      require('plugins.nvim-spectre')
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    -- after = { 'plenary.nvim', 'telescope-ui-select.nvim' },
    dependencies = { 'nvim-telescope/telescope-ui-select.nvim' },
    config = function()
      require('plugins.telescope')
    end,
  },

  {
    'aaronhallaert/advanced-git-search.nvim',
    config = function()
      require('telescope').load_extension('advanced_git_search')
    end,
    dependencies = {
      'nvim-telescope/telescope.nvim',
      -- to show diff splits and open commits in browser
      'tpope/vim-fugitive',
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufRead',
    config = function()
      require('plugins.nvim-treesitter')
    end,
  },

  {
    'chrisgrieser/nvim-various-textobjs',
    config = function()
      require('various-textobjs').setup({ useDefaultKeymaps = true })
    end,
  },

  -- {
  --   'nvim-treesitter/nvim-treesitter-refactor',
  --   event = 'BufRead',
  --   after = 'nvim-treesitter',
  -- },
  { 'nvim-treesitter/playground', cmd = 'TSPlayground' },

  {
    'HiPhish/rainbow-delimiters.nvim',
    config = function()
      local rainbow_delimiters = require('rainbow-delimiters')

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    event = 'BufRead',
    -- after = 'nvim-treesitter'
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },

  {
    'windwp/nvim-autopairs',
    -- after = 'cmp',
    event = 'BufRead',
    config = function()
      require('plugins.autopairs')
    end,
  },

  { 'L3MON4D3/LuaSnip', event = 'InsertCharPre' },
  -- {
  --   name = 'rendition-nvim',
  --   dir = '~/Desktop/rendition-nvim',
  --   config = function()
  --     require('rendition').setup()
  --   end,
  --   dev = true,
  -- },
  {
    'hrsh7th/nvim-cmp',
    name = 'cmp',
    config = function()
      require('plugins.compe')
    end,
    -- wants = {
    --   'LuaSnip',
    --   'cmp_luasnip',
    --   'cmp-nvim-lsp',
    --   'cmp-buffer',
    --   'cmp-path',
    --   'cmp-treesitter',
    --   'cmp-spell',
    --   -- 'cmp-rg',
    -- },
    dependencies = {
      { 'saadparwaiz1/cmp_luasnip', event = 'InsertCharPre' },
      { 'hrsh7th/cmp-buffer', event = 'InsertCharPre' },
      { 'hrsh7th/cmp-path', event = 'InsertCharPre' },
      { 'f3fora/cmp-spell', event = 'InsertCharPre' },
      { 'ray-x/cmp-treesitter', event = 'InsertCharPre' },
      -- { 'lukas-reineke/cmp-rg', event = 'InsertCharPre' },
    },
  },

  {
    'hrsh7th/cmp-nvim-lsp',
    event = 'BufRead',
    -- after = 'cmp'
  },

  {
    'akinsho/nvim-bufferline.lua',
    branch = 'main',
    dependencies = { 'catppuccin' },
    config = function()
      require('plugins.bufferline')
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    -- after = 'plenary.nvim',
    config = function()
      require('plugins.gitsigns')
    end,
  },

  {
    'kyazdani42/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
    -- after = 'nvim-web-devicons',
    config = function()
      require('plugins.nvim-tree')
    end,
  },

  {
    'norcalli/nvim-colorizer.lua',
    event = 'BufRead',
    config = function()
      require('colorizer').setup()
    end,
  },

  {
    'folke/todo-comments.nvim',
    event = 'BufRead',
    -- after = 'plenary.nvim',
    config = function()
      require('todo-comments').setup({})
    end,
  },

  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end,
  },
  {
    'dsznajder/vscode-es7-javascript-react-snippets',
    commit = '2a6a1ffac598d7f5b4097d06c4190c5bcced99d9',
    build = 'yarn install --frozen-lockfile && yarn compile',
  },
  {
    'shortcuts/no-neck-pain.nvim',
    version = '*',
    config = function()
      require('no-neck-pain').setup({
        width = 180,
        buffers = {
          colors = {
            backgroundColor = 'catppuccin',
            blend = -0.1,
          },
          scratchPad = {
            -- set to `false` to
            -- disable auto-saving
            enabled = true,
            -- set to `nil` to default
            -- to current working directory
            location = '~/Documents/',
          },
          bo = {
            filetype = 'md',
          },
        },
      })
    end,
  },
}, {
  defaults = {},
  config = {},
})
