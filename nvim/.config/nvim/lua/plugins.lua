local present, _ = pcall(require, 'packerInit')
local packer

if present then
  packer = require('packer')
else
  return false
end

local use = packer.use

return packer.startup({
  function()
    use('lewis6991/impatient.nvim')
    use({ 'wbthomason/packer.nvim', event = 'VimEnter' })

    -- UI
    -- use({
    --   'j-hui/fidget.nvim',
    --   config = function()
    --     require('fidget').setup({})
    --   end,
    -- })

    use({
      'VonHeikemen/searchbox.nvim',
      requires = {
        { 'MunifTanjim/nui.nvim' },
      },
    })
    use({
      'nvim-lualine/lualine.nvim',
      commit = '2bddaf05084408917f4453739125c388a540d7f7',
      config = function()
        require('plugins.lualine')
      end,
    })
    use({
      'luukvbaal/stabilize.nvim',
      config = function()
        require('stabilize').setup()
      end,
    })
    use({
      'lukas-reineke/indent-blankline.nvim',
      event = 'BufRead',
      config = function()
        require('plugins.indentline')
      end,
    })
    use({
      'monsonjeremy/onedark.nvim',
      branch = 'treesitter',
      after = 'lualine.nvim',
      config = function()
        require('plugins.onedark').setupOneDark()
      end,
    })
    use({
      'kyazdani42/nvim-web-devicons',
      event = 'BufRead',
      config = function()
        require('plugins.nvim-web-devicons')
      end,
    })

    use({
      'gpanders/editorconfig.nvim',
      event = 'BufRead',
    })

    use({
      'folke/noice.nvim',
      event = 'VimEnter',
      config = function()
        require('noice').setup({
          lsp_progress = {
            enabled = true,
            format = 'lsp_progress',
            format_done = 'lsp_progress_done',
            throttle = 2000, -- frequency to update lsp progress message
            view = 'mini',
          },
        })
      end,
      requires = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        'MunifTanjim/nui.nvim',
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        --'rcarriga/nvim-notify',
      },
    })

    use({
      'github/copilot.vim',
      event = 'InsertEnter',
    })

    -- LSP
    use({
      'glepnir/lspsaga.nvim',
      branch = 'main',
      config = function()
        require('lspsaga').setup({})
      end,
    })
    -- use({ 'ray-x/lsp_signature.nvim', event = 'BufRead' })
    use({ 'folke/neodev.nvim' })
    use({ 'williamboman/nvim-lsp-installer', event = 'BufRead' })
    use({ 'nvim-lua/lsp_extensions.nvim', event = 'BufRead' })
    use({
      'ojroques/nvim-lspfuzzy',
      requires = {
        { 'junegunn/fzf', event = 'BufRead' },
        { 'junegunn/fzf.vim', event = 'BufRead' },
      },
      event = 'BufRead',
      config = function()
        require('lspfuzzy').setup({})
      end,
    })
    use({
      'filipdutescu/renamer.nvim',
      event = 'BufRead',
      after = 'plenary.nvim',
      requires = { { 'nvim-lua/plenary.nvim' } },
      config = function()
        require('renamer').setup({
          min_width = 30,
          max_width = 80,
        })
      end,
    })
    use({
      'folke/trouble.nvim',
      event = 'BufRead',
      after = 'nvim-web-devicons',
      config = function()
        require('trouble').setup({})
      end,
    })
    use({
      'cshuaimin/ssr.nvim',
      module = 'ssr',
    })
    use({
      'onsails/lspkind-nvim',
      event = 'BufRead',
      module = 'lspkind',
    })
    use({
      'neovim/nvim-lspconfig',
      config = function()
        require('lsp')
      end,
      after = {
        'cmp',
        'cmp-nvim-lsp',
        'nvim-lsp-installer',
        'lspsaga.nvim',
        -- 'lsp_signature.nvim',
        'neodev.nvim',
        'lsp_extensions.nvim',
        'nvim-lspfuzzy',
        'trouble.nvim',
        'lspkind-nvim',
      },
    })

    use({
      'jose-elias-alvarez/null-ls.nvim',
      after = 'nvim-lspconfig',
      module = 'null-ls',
    })

    use({
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      after = 'nvim-lspconfig',
      module = 'nvim-lsp-ts-utils',
    })

    use({
      'simrat39/rust-tools.nvim',
      ft = 'rs',
      config = function()
        require('rust-tools').setup()
      end,
    })

    -- Terminal
    use({
      'akinsho/nvim-toggleterm.lua',
      branch = 'main',
      cmd = 'ToggleTerm',
      config = function()
        require('plugins.toggleterm')
      end,
    })

    -- Navigation / Helpers
    use({ 'tpope/vim-fugitive', cmd = { 'Git' } })
    use({ 'nvim-lua/plenary.nvim' })
    use({ 'nvim-lua/popup.nvim', after = 'plenary.nvim' })

    -- use({
    --   'famiu/nvim-reload',
    --   cmd = 'Reload',
    --   config = function()
    --     local reload = require('nvim-reload')
    --     local plugin_dir = vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua'
    --     reload.vim_reload_dirs = {}
    --     reload.lua_reload_dirs = {}
    --     reload.post_reload_hook = function()
    --       vim.cmd('source ' .. plugin_dir)
    --       vim.cmd('colorscheme onedark')
    --     end
    --   end,
    -- })
    -- use({ 'sindrets/diffview.nvim', cmd = 'DiffviewOpen' })
    -- use({ 'simrat39/symbols-outline.nvim', cmd = 'SymbolsOutline' })

    use({ 'nanotee/zoxide.vim', cmd = { 'z', 'Zi', 'Z' } })
    use({
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end,
      event = 'BufRead',
    })
    -- use({ 'tpope/vim-surround', event = 'BufRead' })
    use({
      'echasnovski/mini.nvim',
      branch = 'stable',
      event = 'BufRead',
      config = function()
        require('mini.surround').setup({})
      end,
    })
    use({ 'tpope/vim-repeat', keys = '.' })
    use({ 'chaoren/vim-wordmotion', event = 'BufRead' })
    use({ 'tweekmonster/startuptime.vim', cmd = 'StartupTime' })
    -- use({ 'tversteeg/registers.nvim', cmd = 'Registers' })
    -- use({
    --   'phaazon/hop.nvim',
    --   cmd = { 'HopWord', 'HopLine', 'HopChar1', 'HopChar2', 'HopPattern' },
    --   as = 'hop',
    --   config = function()
    --     require('plugins.hop')
    --   end,
    -- })

    use({ 'fedepujol/move.nvim', cmd = { 'MoveLine', 'MoveBlock' } })

    use({
      'goolord/alpha-nvim',
      config = function()
        require('plugins.dashboard')
      end,
    })

    use({
      'windwp/nvim-spectre',
      module = 'spectre',
      config = function()
        require('plugins.nvim-spectre')
      end,
    })

    use({
      'nvim-telescope/telescope.nvim',
      cmd = 'Telescope',
      after = { 'plenary.nvim', 'telescope-ui-select.nvim' },
      requires = { 'nvim-telescope/telescope-ui-select.nvim' },
      config = function()
        require('plugins.telescope')
      end,
    })

    use({
      'nvim-treesitter/nvim-treesitter',
      -- commit = '4cccb6f494eb255b32a290d37c35ca12584c74d0',
      run = ':TSUpdate',
      event = 'BufRead',
      config = function()
        require('plugins.nvim-treesitter')
      end,
    })

    use({
      'nvim-treesitter/nvim-treesitter-refactor',
      event = 'BufRead',
      after = 'nvim-treesitter',
    })

    use({ 'nvim-treesitter/playground', cmd = 'TSPlayground' })

    use({ 'p00f/nvim-ts-rainbow', event = 'BufRead', after = 'nvim-treesitter' })

    use({ 'windwp/nvim-ts-autotag', event = 'BufRead', after = 'nvim-treesitter' })

    use({
      'windwp/nvim-autopairs',
      after = 'cmp',
      event = 'BufRead',
      config = function()
        require('plugins.autopairs')
      end,
    })

    use({
      'hrsh7th/nvim-cmp',
      as = 'cmp',
      config = function()
        require('plugins.compe')
      end,
      wants = {
        'LuaSnip',
        'cmp_luasnip',
        'cmp-nvim-lsp',
        'cmp-buffer',
        'cmp-path',
        'cmp-treesitter',
        'cmp-spell',
        -- 'cmp-rg',
      },
      requires = {
        { 'L3MON4D3/LuaSnip', event = 'InsertCharPre' },
        { 'saadparwaiz1/cmp_luasnip', event = 'InsertCharPre' },
        { 'hrsh7th/cmp-buffer', event = 'InsertCharPre' },
        { 'hrsh7th/cmp-path', event = 'InsertCharPre' },
        { 'f3fora/cmp-spell', event = 'InsertCharPre' },
        { 'ray-x/cmp-treesitter', event = 'InsertCharPre' },
        -- { 'lukas-reineke/cmp-rg', event = 'InsertCharPre' },
      },
    })

    use({ 'hrsh7th/cmp-nvim-lsp', event = 'BufRead', after = 'cmp' })

    use({
      'akinsho/nvim-bufferline.lua',
      branch = 'main',
      event = 'BufRead',
      config = function()
        require('plugins.bufferline')
      end,
    })

    use({
      'lewis6991/gitsigns.nvim',
      event = 'BufRead',
      after = 'plenary.nvim',
      config = function()
        require('plugins.gitsigns')
      end,
    })

    use({
      'kyazdani42/nvim-tree.lua',
      cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
      after = 'nvim-web-devicons',
      config = function()
        require('plugins.nvim-tree')
      end,
    })

    use({
      'norcalli/nvim-colorizer.lua',
      event = 'BufRead',
      config = function()
        require('colorizer').setup()
      end,
    })

    use({
      'folke/todo-comments.nvim',
      event = 'BufRead',
      after = 'plenary.nvim',
      config = function()
        require('todo-comments').setup({})
      end,
    })

    use({
      'folke/which-key.nvim',
      config = function()
        require('which-key').setup()
      end,
    })

    use({
      'dsznajder/vscode-es7-javascript-react-snippets',
      commit = '2a6a1ffac598d7f5b4097d06c4190c5bcced99d9',
      run = 'yarn install --frozen-lockfile && yarn compile',
    })

    -- use({
    --   'TimUntersberger/neogit',
    --   cmd = 'Neogit',
    --   after = 'plenary.nvim',
    --   config = function()
    --     require('neogit').setup({})
    --   end,
    -- })

    -- use({
    --   'AckslD/nvim-neoclip.lua',
    --   event = 'BufRead',
    --   config = function()
    --     require('neoclip').setup()
    --   end,
    -- })

    use({
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
    })

    -- use({
    --   'danymat/neogen',
    --   module = 'neogen',
    --   cmd = 'Neogen',
    --   config = function()
    --     require('neogen').setup({
    --       enabled = true,
    --     })
    --   end,
    -- })

    -- use({
    --   'ThePrimeagen/refactoring.nvim',
    --   event = 'BufRead',
    --   requires = {
    --     { 'nvim-lua/plenary.nvim' },
    --     { 'nvim-treesitter/nvim-treesitter' },
    --   },
    -- })
  end,
  {
    config = {
      -- Move to lua dir so impatient.nvim can cache it
      compile_path = vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua',
    },
  },
})
