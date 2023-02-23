require('lazy').setup({
  'lewis6991/impatient.nvim',
  { 'wbthomason/packer.nvim', event = 'VimEnter' },

  -- UI
  -- {
  --   'j-hui/fidget.nvim',
  --   config = function()
  --     require('fidget').setup({},
  --   end,
  -- },

  {
    'VonHeikemen/searchbox.nvim',
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    commit = '2bddaf05084408917f4453739125c388a540d7f7',
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
    event = 'BufRead',
    config = function()
      require('plugins.indentline')
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require('plugins.catppuccin-config')
    end,
  },
  -- {
  --   'monsonjeremy/onedark.nvim',
  --   branch = 'treesitter',
  --   -- after = 'lualine.nvim',
  --   config = function()
  --     require('plugins.onedark').setupOneDark()
  --   end,
  -- },
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
            enabled = true,
            format = 'lsp_progress',
            format_done = 'lsp_progress_done',
            throttle = 10000, -- frequency to update lsp progress message
            view = 'mini',
            message = {
              -- Messages shown by lsp servers
              enabled = true,
              view = 'mini',
              opts = {
                title = 'LSP',
                replace = true,
              },
            },
          },
        },
      })
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      -- 'rcarriga/nvim-notify',
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
    'zbirenbaum/copilot-cmp',
    -- after = { 'copilot.lua' },
    config = function()
      require('copilot_cmp').setup()
    end,
  },

  -- LSP
  {
    'glepnir/lspsaga.nvim',
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
  { 'williamboman/nvim-lsp-installer', event = 'BufRead' },
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
    'jose-elias-alvarez/null-ls.nvim',
    -- after = 'nvim-lspconfig',
    -- module = 'null-ls',
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
    branch = 'stable',
    event = 'BufRead',
    config = function()
      require('mini.surround').setup({})
    end,
  },
  { 'tpope/vim-repeat', keys = { '.', mode = 'n' } },
  { 'chaoren/vim-wordmotion', event = 'BufRead' },
  { 'tweekmonster/startuptime.vim', cmd = 'StartupTime' },
  { 'fedepujol/move.nvim', cmd = { 'MoveLine', 'MoveBlock' } },
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
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufRead',
    config = function()
      require('plugins.nvim-treesitter')
    end,
  },

  -- {
  --   'nvim-treesitter/nvim-treesitter-refactor',
  --   event = 'BufRead',
  --   after = 'nvim-treesitter',
  -- },
  {
    'tzachar/local-highlight.nvim',
    config = function()
      require('local-highlight').setup({
        hlgroup = 'IlluminatedWordText',
      })
    end,
  },

  { 'nvim-treesitter/playground', cmd = 'TSPlayground' },

  {
    'HiPhish/nvim-ts-rainbow2',
    event = 'BufRead',
    -- after = 'nvim-treesitter'
  },

  {
    'windwp/nvim-ts-autotag',
    event = 'BufRead',
    -- after = 'nvim-treesitter'
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
    after = 'catppuccin',
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
    build = 'npm ci  && npm run compile',
  },

  {
    'nathom/filetype.nvim',
    config = function()
      require('filetype').setup({
        overrides = {
          extensions = {
            -- Set the filetype of *.pn files to potion
            exs = 'elixir',
            tf = 'terraform',
          },
          literal = {
            ['.eslintrc'] = 'json',
            ['.prettierrc'] = 'json',
            ['.babelrc'] = 'json',
            ['.nycrc'] = 'json',
            ['.env'] = 'bash',
            ['.env.local'] = 'bash',
            ['.env.development'] = 'bash',
            ['.env.production'] = 'bash',
            ['.env.sandbox'] = 'bash',
            ['.env.staging'] = 'bash',
            ['.env.sample'] = 'bash',
            ['.env.test'] = 'bash',
          },
        },
      })
    end,
  },
}, {
  config = {
    -- Move to lua dir so impatient.nvim can cache it
    -- compile_path = vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua',
  },
})
