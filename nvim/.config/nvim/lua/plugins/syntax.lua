return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufRead',
    init = function(plugin)
      local runtime_paths = vim.opt.runtimepath:get()
      local after_dir = plugin.dir .. '/after'

      if not vim.tbl_contains(runtime_paths, plugin.dir) then
        vim.opt.runtimepath:append(plugin.dir)
      end

      runtime_paths = vim.opt.runtimepath:get()
      if vim.fn.isdirectory(after_dir) == 1 and not vim.tbl_contains(runtime_paths, after_dir) then
        vim.opt.runtimepath:append(after_dir)
      end

      for ft, lang in pairs({
        javascriptreact = 'javascript',
        jsx = 'javascript',
        ts = 'typescript',
        ['typescript.tsx'] = 'tsx',
        typescriptreact = 'tsx',
      }) do
        vim.treesitter.language.register(lang, ft)
      end
    end,
    config = function()
      require('plugin_configs.nvim-treesitter')
    end,
  },
  { 'nvim-treesitter/playground', cmd = 'TSPlayground' },
  {
    'HiPhish/rainbow-delimiters.nvim',
    config = function()
      local rainbow_delimiters = require('rainbow-delimiters')

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy.global,
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
    ft = {
      'astro',
      'eelixir',
      'eruby',
      'heex',
      'html',
      'javascriptreact',
      'php',
      'svelte',
      'templ',
      'typescriptreact',
      'vue',
      'xml',
    },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
}
