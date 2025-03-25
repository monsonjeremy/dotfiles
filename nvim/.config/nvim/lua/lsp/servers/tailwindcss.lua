local on_attach = require('lsp.on_attach')
local lspconfig = require('lspconfig')

lspconfig.tailwindcss.setup({
  root_dir = require('lspconfig').util.root_pattern(
    'tailwind.config.js',
    'tailwind.config.ts',
    'package.json',
    'mix.exs'
  ),
  filetypes = {
    'djangohtml',
    'handlebars',
    'hbs',
    'html',
    'heex',
    'markdown',
    'mdx',
    'elixir',
    'css',
    'scss',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  init_options = {
    userLanguages = {
      ['phoenix-heex'] = 'html',
      elixir = 'html',
      heex = 'html',
      eelixir = 'html',
      eruby = 'erb',
    },
  },
  settings = {
    tailwindCSS = {
      lint = {
        cssConflict = 'ignore',
      },
      -- experimental = {
      --   classRegex = {
      --     '[a-zA-Z]+ClassName=\\"([^\\"]*)\\"',
      --     'className[a-zA-Z]+=\\"([^\\"]*)\\"',
      --     '[`\'"`]([^\'"`,;]*)[`\'"`]',
      --     '`([^`]*)`',
      --     'twMerge\\(([\\S\\s]*?)\\)',
      --     '(?:twMerge|twJoin)\\(([^\\);]*)[\\);]',
      --   },
      -- },
      experimental = {
        classRegex = {
          { 'class[:=]\\s*"([^"]*)"', 'class' }, -- Basic class support
          { 'class[:=]\\s*\'([^\']*)\'', 'class' }, -- Support for single-quoted class strings
          { 'class[:=]\\s*~s\\(([^)]*)\\)', 'class' }, -- Support for Phoenix Sigil Syntax
        },
      },
      includeLanguages = {
        elixir = 'html',
        heex = 'html',
      },
    },
  },
})
