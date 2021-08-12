local lsp_config = require('lspconfig')
local on_attach = require('lsp.on_attach')
local eslint = require('lsp.servers.efm.eslint')
local prettier = require('lsp.servers.efm.prettier')

local efm_config = os.getenv('HOME') .. '/.config/nvim/lua/lsp/servers/efm/config.yaml'
local efm_log_dir = '/tmp/'
local efm_root_markers = { 'package.json', '.git/', '.zshrc' }

local efm_languages = {
  yaml = { prettier },
  json = { prettier },
  markdown = { prettier },
  md = { prettier },
  javascript = { eslint },
  javascriptreact = { eslint },
  typescript = { eslint },
  typescriptreact = { eslint },
  css = { prettier },
  scss = { prettier },
  sass = { prettier },
  less = { prettier },
  graphql = { prettier },
  vue = { prettier },
  html = { prettier },
}

return {
  cmd = {
    'efm-langserver',
    '-c',
    efm_config,
    '-logfile',
    efm_log_dir .. 'efm.log',
  },
  filetypes = {
    'json',
    'css',
    'scss',
    'yaml',
    'markdown',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
    on_attach(client)
  end,
  root_dir = lsp_config.util.root_pattern(unpack(efm_root_markers)),
  init_options = {
    documentFormatting = true,
    code_action = true,
  },
  settings = {
    rootMarkers = efm_root_markers,
    languages = efm_languages,
  },
}
