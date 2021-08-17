local present, _ = pcall(require, 'packerInit')
local packer

if present then
  packer = require 'packer'
else
  return false
end

local use = packer.use

return packer.startup(function()
  use({ 'wbthomason/packer.nvim', event = 'VimEnter' })

  -- UI
  use({
    'hoob3rt/lualine.nvim',
    config = function()
      require('plugins.lualine')
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
    after = 'lualine.nvim',
    config = function()
      require('plugins.onedark').setupOneDark()
    end,
  })
  use({
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins.nvim-web-devicons')
    end,
  })

  -- LSP
  use({ 'glepnir/lspsaga.nvim', event = 'BufRead' })
  use({ 'ray-x/lsp_signature.nvim', event = 'BufRead' })
  use({ 'folke/lua-dev.nvim', event = 'BufRead' })
  use({ 'kabouzeid/nvim-lspinstall', event = 'BufRead' })
  use({ 'nvim-lua/lsp_extensions.nvim', event = 'BufRead' })
  use({
    'ojroques/nvim-lspfuzzy',
    requires = { { 'junegunn/fzf' }, { 'junegunn/fzf.vim' } },
    config = function()
      require('lspfuzzy').setup({})
    end,
  })
  use({
    'folke/trouble.nvim',
    event = 'BufRead',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup({})
    end,
  })
  use({
    'onsails/lspkind-nvim',
    event = 'BufRead',
    config = function()
      require('plugins.lspkind')
    end,
  })
  use({
    'neovim/nvim-lspconfig',
    config = function()
      require('lsp')
    end,
    after = {
      'nvim-lspinstall',
      'lspsaga.nvim',
      'lsp_signature.nvim',
      'lua-dev.nvim',
      'lsp_extensions.nvim',
      'nvim-lspfuzzy',
      'trouble.nvim',
      'lspkind-nvim',
    },
  })

  -- Terminal
  use({
    'akinsho/nvim-toggleterm.lua',
    cmd = 'ToggleTerm',
    config = function()
      require('plugins.toggleterm')
    end,
  })

  -- Navigation / Helpers
  use({ 'tpope/vim-fugitive', cmd = { 'Git' } })
  use { 'nvim-lua/plenary.nvim' }
  use { 'nvim-lua/popup.nvim', after = 'plenary.nvim' }
  use({ 'famiu/nvim-reload', cmd = 'Reload' })
  use({ 'sindrets/diffview.nvim', cmd = 'DiffviewOpen' })
  use({ 'nanotee/zoxide.vim', cmd = { 'z', 'Zi', 'Z' } })
  use({ 'simrat39/symbols-outline.nvim', cmd = 'SymbolsOutline' })
  use({ 'b3nj5m1n/kommentary', event = 'BufRead' })
  use({ 'tpope/vim-surround', event = 'BufRead' })
  use({ 'tpope/vim-repeat', keys = '.' })
  use({ 'AndrewRadev/dsf.vim', keys = 'dsf' })
  use({ 'chaoren/vim-wordmotion', event = 'BufRead' })
  use({ 'tweekmonster/startuptime.vim', cmd = 'StartupTime' })
  use({ 'tversteeg/registers.nvim', cmd = 'Registers' })
  use({ 'vuki656/package-info.nvim', ft = 'json' })
  use({
    'phaazon/hop.nvim',
    cmd = { 'HopWord', 'HopLine', 'HopChar1', 'HopChar2', 'HopPattern' },
    as = 'hop',
    config = function()
      require('plugins.hop')
    end,
  })

  use({
    'matze/vim-move',
    keys = { { 'v', '∆' }, { 'v', '˚' }, { 'n', '∆' }, { 'n', '˚' } },
    config = function()
      require('plugins.vim-move')
    end,
  })

  use({
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('plugins.dashboard')
    end,
  })

  use({
    'windwp/nvim-spectre',
    requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('plugins.nvim-spectre')
    end,
  })

  use({
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    after = 'plenary.nvim',
    config = function()
      require('plugins.telescope')
    end,
  })

  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSupdate',
    branch = '0.5-compat',
    event = 'BufRead',
    requires = 'nvim-treesitter',
    config = function()
      require('plugins.nvim-treesitter')
    end,
  })

  use({
    'nvim-treesitter/nvim-treesitter-refactor',
    event = 'BufRead',
    requires = 'nvim-treesitter',
  })

  use({ 'nvim-treesitter/playground', cmd = 'TSPlayground' })

  use({ 'p00f/nvim-ts-rainbow', event = 'BufRead', requires = 'nvim-treesitter' })

  use({ 'windwp/nvim-ts-autotag', event = 'BufRead', requires = 'nvim-treesitter' })

  use({
    'windwp/nvim-autopairs',
    after = 'nvim-compe',
    config = function()
      require('plugins.autopairs')
    end,
  })

  use({
    'hrsh7th/nvim-compe',
    event = 'InsertEnter',
    config = function()
      require('plugins.compe')
    end,
    wants = 'vim-vsnip',
    requires = {
      {
        'hrsh7th/vim-vsnip',
        wants = 'vim-vsnip-integ',
        event = 'InsertCharPre',
        config = function()
          require 'plugins.vsnip'
        end,
      },
      { 'hrsh7th/vim-vsnip-integ', event = 'InsertCharPre' },
    },
  })

  use({
    'akinsho/nvim-bufferline.lua',
    config = function()
      require('plugins.bufferline')
    end,
  })

  use({
    'lewis6991/gitsigns.nvim',
    after = 'plenary.nvim',
    config = function()
      require('plugins.gitsigns')
    end,
  })

  use({
    'kyazdani42/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
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
    'kkoomen/vim-doge',
    event = 'BufRead',
    run = function()
      vim.fn['doge#install']()
    end,
  })

  use({
    'dsznajder/vscode-es7-javascript-react-snippets',
    event = 'InsertEnter',
    run = 'yarn install --frozen-lockfile && yarn compile',
  })

  use({
    'TimUntersberger/neogit',
    cmd = 'Neogit',
    after = 'plenary.nvim',
    config = function()
      require('neogit').setup({})
    end,
  })
end)
