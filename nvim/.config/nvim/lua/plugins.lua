require('lazy').setup({
  {
    'enochchau/nvim-pretty-ts-errors',
    build = 'npm install',
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
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,

    config = function()
      require('plugins.catppuccin-config')
    end,
  },
  {
    'echasnovski/mini.icons',
    opts = {},
    lazy = true,
    specs = {
      { 'nvim-tree/nvim-web-devicons', enabled = false, optional = true },
    },
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },

  {
    'gpanders/editorconfig.nvim',
    event = 'BufRead',
  },
  {
    'rachartier/tiny-glimmer.nvim',
    event = 'VeryLazy',
    opts = {
      default_animation = 'fade',
      animations = {
        fade = {
          max_duration = 700,
          min_duration = 500,
          easing = 'outQuad',
          chars_for_max_duration = 10,
        },
      },
    },
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
        },
        views = {
          notify = { merge = true, replace = true, title = 'LSP' },
        },
      })
    end,
  },

  {
    'zbirenbaum/copilot.lua',
    event = 'VimEnter',
    config = function()
      require('copilot').setup({
        suggestion = {
          enabled = false,
        },
        panel = { enabled = false },
        logger = {
          file_log_level = vim.log.levels.DEBUG,
        },
      })
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
  -- { 'ray-x/lsp_signature.nvim', event = 'BufRead' },
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings
  {
    'mason-org/mason.nvim',
    build = ':MasonUpdate', -- :MasonUpdate updates registry contents
  },
  'mason-org/mason-lspconfig.nvim',
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
    dependencies = { 'saghen/blink.cmp' },
    config = function()
      require('lsp')
    end,
  },

  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    config = function()
      require('plugins.conform')
    end,
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('plugins.lint')
    end,
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
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
    'echasnovski/mini.nvim',
    version = '*',
    event = 'BufRead',
    config = function()
      require('mini.surround').setup({})
      require('mini.ai').setup({})
    end,
  },
  { 'tpope/vim-repeat', keys = { '.', mode = 'n' } },
  { 'chaoren/vim-wordmotion', event = 'BufRead' },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
    },
  },
  {
    'fedepujol/move.nvim',
    cmd = { 'MoveLine', 'MoveBlock' },
    config = function()
      require('move').setup()
    end,
  },

  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup({
        keymaps = {
          replace = { n = '<leader>r' },
        },
      })
    end,
  },

  {
    'folke/snacks.nvim',
    opts = {
      picker = {},
      explorer = {},
      health = {},
      statuscolumn = {},
      notifier = {},
      notify = {},
      lazygit = {},
      indent = {},
      words = {},
      terminal = {},
    },
    keys = {
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
      {
        '<c-/>',
        function()
          Snacks.terminal()
        end,
        desc = 'Toggle Terminal',
      },
      {
        '<leader>ff',
        function()
          Snacks.picker.files()
        end,
        desc = 'Find Files',
      },
      {
        '<leader>fg',
        function()
          Snacks.picker.grep()
        end,
        desc = 'Grep',
      },
      {
        '<leader>fb',
        function()
          Snacks.picker.buffers()
        end,
        desc = 'Buffers',
      },
      {
        '<leader>fh',
        function()
          Snacks.picker.help()
        end,
        desc = 'Help Tags',
      },
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
      require('various-textobjs').setup({ keymaps = { useDefaults = true } })
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
    event = 'BufRead',
    config = function()
      require('plugins.autopairs')
    end,
  },

  -- Source replacement
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      'fang2hou/blink-copilot',
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        config = function()
          --- I had to add this option compared to the old syntax
          require('luasnip.loaders.from_vscode').load()
        end,
      },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        default = { 'copilot', 'lsp', 'buffer', 'snippets', 'path' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },
      completion = {
        ghost_text = { enabled = true, show_with_menu = true },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
        },
      },
      keymap = {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<CR>'] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          'snippet_forward',
          'fallback',
        },
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },
      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
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
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
      { '<leader>e', ':Neotree toggle<CR>', desc = 'Toggle Neo-tree' },
    },
    config = function()
      require('neo-tree').setup(require('plugins.neo-tree'))
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
