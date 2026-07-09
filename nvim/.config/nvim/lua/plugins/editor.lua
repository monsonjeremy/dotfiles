return {
  {
    'davidosomething/format-ts-errors.nvim',
    config = function()
      require('format-ts-errors').setup({
        add_markdown = true,
        start_indent_level = 0,
      })
    end,
  },
  { 'gpanders/editorconfig.nvim', event = 'BufRead' },
  {
    'zbirenbaum/copilot.lua',
    event = 'VimEnter',
    config = function()
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        logger = { file_log_level = vim.log.levels.DEBUG },
      })
    end,
  },
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    config = function()
      require('trouble').setup({})
    end,
  },
  { 'cshuaimin/ssr.nvim' },
  {
    'chrisgrieser/nvim-various-textobjs',
    config = function()
      require('various-textobjs').setup({ keymaps = { useDefaults = true } })
    end,
  },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-lua/popup.nvim' },
  { 'nanotee/zoxide.vim' },
  {
    'echasnovski/mini.nvim',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('mini.surround').setup({})
      require('mini.ai').setup({})
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({ check_ts = true })
    end,
  },
  {
    'tpope/vim-repeat',
    keys = {
      { '.', mode = 'n', desc = 'Repeat last change' },
    },
  },
  { 'chaoren/vim-wordmotion', event = 'VeryLazy' },
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
    'dmtrKovalenko/fff.nvim',
    build = function()
      require('fff.download').download_or_build_binary()
    end,
    opts = {
      prompt = '   ',
      layout = {
        height = 0.8,
        width = 0.87,
        prompt_position = 'top',
        preview_position = 'right',
        preview_size = 0.55,
        flex = { size = 120, wrap = 'top' },
        path_shorten_strategy = 'end',
      },
    },
    lazy = false,
  },
  {
    'folke/snacks.nvim',
    opts = {
      picker = {},
      explorer = {},
      health = {},
      statuscolumn = {},
      notifier = { enabled = false },
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
          require('snacks').lazygit()
        end,
        desc = 'Lazygit',
      },
      {
        '<c-/>',
        function()
          require('snacks').terminal()
        end,
        desc = 'Toggle Terminal',
      },
    },
  },
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    config = function()
      require('todo-comments').setup({})
    end,
  },
  {
    'dsznajder/vscode-es7-javascript-react-snippets',
    commit = '2a6a1ffac598d7f5b4097d06c4190c5bcced99d9',
    build = 'yarn install --frozen-lockfile && yarn compile',
  },
}
