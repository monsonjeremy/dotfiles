return {
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = { theme = 'catppuccin' },
        sections = {
          lualine_c = { { 'diagnostics', sources = { 'nvim_diagnostic' } }, { 'filename' } },
        },
      })
    end,
  },
  {
    'akinsho/nvim-bufferline.lua',
    branch = 'main',
    dependencies = { 'catppuccin' },
    config = function()
      require('bufferline').setup({
        options = {
          numbers = 'none',
          left_trunc_marker = '',
          right_trunc_marker = '',
          max_name_length = 18,
          max_prefix_length = 15,
          tab_size = 20,
          offsets = { { filetype = 'neo-tree', text = 'Files' } },
          enforce_regular_tabs = true,
          view = 'multiwindow',
          show_buffer_close_icons = true,
          separator_style = 'thin',
          sort_by = 'directory',
        },
      })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = function()
      require('gitsigns').setup({
        current_line_blame = true,
      })
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    config = function()
      require('neo-tree').setup(require('plugin_configs.neo-tree'))
    end,
  },
  {
    'luukvbaal/stabilize.nvim',
    config = function()
      require('stabilize').setup()
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
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
        lsp = {
          override = {
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = false,
          },
          signature = {
            auto_open = {
              enabled = false,
            },
          },
        },
        views = {
          notify = { merge = true, replace = true, title = 'LSP' },
        },
      })
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
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      local wk = require('which-key')
      wk.setup({
        preset = 'classic',
      })

      wk.add({
        { '<leader>9', group = '99 AI', mode = { 'n', 'v' } },
        { '<leader>b', group = 'Buffers', mode = { 'n', 'v' } },
        { '<leader>c', group = 'Code', mode = { 'n', 'v' } },
        { '<leader>d', group = 'Delete/Definition', mode = { 'n', 'v' } },
        { '<leader>f', group = 'Files/Format', mode = { 'n', 'v' } },
        { '<leader>g', group = 'Git', mode = { 'n', 'v' } },
        { '<leader>l', group = 'Lint', mode = { 'n', 'v' } },
        { '<leader>n', group = 'Navigation', mode = { 'n', 'v' } },
        -- { '<leader>p', group = 'Picker/Project', mode = { 'n', 'v' } },
        { '<leader>s', group = 'Search/Replace', mode = { 'n', 'v' } },
        { '<leader>t', group = 'Terminal', mode = { 'n', 'v' } },
        { '<leader>v', group = 'Vim Config', mode = { 'n', 'v' } },
        { '<leader>w', group = 'Write/Workflow', mode = { 'n', 'v' } },
        { '<leader>x', group = 'Execute', mode = { 'n', 'v' } },
      })
    end,
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
            enabled = true,
            location = '~/Documents/',
          },
          bo = {
            filetype = 'md',
          },
        },
      })
    end,
  },
}
