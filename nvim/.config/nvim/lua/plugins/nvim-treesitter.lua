local present, treesitter = pcall(require, 'nvim-treesitter.configs')
if not present then
  return
end

treesitter.setup({
  autopairs = { enable = true },
  rainbow = {
    max_file_lines = 2000,
    enable = true,
    -- Which query to use for finding delimiters
    query = 'rainbow-delimiters',
    -- Highlight the entire buffer all at once
    strategy = require('rainbow-delimiters').strategy.global,
  },
  ensure_installed = {
    'bash',
    'comment',
    'css',
    'dockerfile',
    'dot',
    'eex',
    'elixir',
    'erlang',
    'fennel',
    'gleam',
    'go',
    'graphql',
    'hcl',
    'heex',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'json5',
    'jsonc',
    'lua',
    'prisma',
    'python',
    'regex',
    'rust',
    'scss',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'yaml',
  },
  highlight = { enable = true, use_languagetree = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
  },
})
