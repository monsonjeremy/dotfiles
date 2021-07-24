local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'kabouzeid/nvim-lspinstall'
  use 'tpope/vim-fugitive'
  use 'ryanoasis/vim-devicons'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/lsp_extensions.nvim'
  use 'glepnir/lspsaga.nvim'
  use 'akinsho/nvim-toggleterm.lua'
  use 'hrsh7th/vim-vsnip'
  use 'famiu/nvim-reload'
  use 'sindrets/diffview.nvim'
  use 'nanotee/zoxide.vim'
  use 'simrat39/symbols-outline.nvim'
  use 'b3nj5m1n/kommentary'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'AndrewRadev/dsf.vim'
  use 'chaoren/vim-wordmotion'
  use 'tweekmonster/startuptime.vim'
  use 'ray-x/lsp_signature.nvim'
  use "folke/lua-dev.nvim"
  use 'nvim-treesitter/playground'
  use 'tversteeg/registers.nvim'

  use {
    'phaazon/hop.nvim',
    as = 'hop',
    config = function()
      require('plugins.hop')
    end
  }

  use {
    'hoob3rt/lualine.nvim',
    config = function()
      require 'plugins.lualine'
    end
  }

  use {
    'folke/tokyonight.nvim',
    after = 'lualine.nvim',
    config = function()
      require('plugins.tokyonight')
    end
  }

  use {
    'ful1e5/onedark.nvim',
    after = 'lualine.nvim',
    config = function()
      require('plugins.onedark').setupOneDark()
    end
  }

  use {
    'shaunsingh/nord.nvim',
    config = function()
      require('plugins.nord')
    end
  }

  use {
    'matze/vim-move',
    config = function()
      require('plugins.vim-move')
    end
  }

  use {
    'Yggdroot/indentLine',
    config = function()
      require('plugins.indentline')
    end
  }

  use {
    'glepnir/dashboard-nvim',
    config = function()
      require('plugins.dashboard')
    end
  }

  use {
    'neovim/nvim-lspconfig',
    config = function() require('lsp') end
  }

  use {
    'windwp/nvim-spectre',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = function()
      require('plugins.nvim-spectre')
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = function()
      require('plugins.telescope')
    end
  }

  use {
    'kyazdani42/nvim-web-devicons',
    config = function ()
      require('plugins.nvim-web-devicons')
    end
  }

  use {
    'junegunn/fzf.vim',
    requires = {
      'junegunn/fzf', run = function() vim.fn['fzf#install']() end
    }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSupdate',
    config = function() require("plugins.nvim-treesitter") end
  }
  use { 'nvim-treesitter/nvim-treesitter-refactor', requires = { 'nvim-treesitter/nvim-treesitter' } }
  use { 'p00f/nvim-ts-rainbow', requires = { 'nvim-treesitter/nvim-treesitter' }, branch = 'master' }
  use { 'windwp/nvim-ts-autotag', requires = { 'nvim-treesitter/nvim-treesitter' } }

  use {
    'hrsh7th/nvim-compe',
    requires = {'hrsh7th/vim-vsnip'}
  }

  use {
    'ojroques/nvim-lspfuzzy',
    requires = {
      {'junegunn/fzf'},
      {'junegunn/fzf.vim'},
    },
    config = function()
      require('lspfuzzy').setup({})
    end
  }

  use {
    'akinsho/nvim-bufferline.lua',
    config = function() require('plugins.bufferline') end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function() require('plugins.gitsigns') end
  }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins.nvim-tree')
    end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  }

  use {
    'onsails/lspkind-nvim',
    config = function()
      require('plugins.lspkind')
    end
  }

  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({})
    end
  }

  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end
  }

  use {
    'kkoomen/vim-doge',
    run = function() vim.fn['doge#install']() end
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt" },
        check_ts = true,
      })
    end
  }

  use {
    'dsznajder/vscode-es7-javascript-react-snippets',
    run = 'yarn install --frozen-lockfile && yarn compile'
  }

  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('neogit').setup({})
    end
  }

end, {
  display = {
    open_fn = require('packer.util').float,
  }
})
