local base_config = require('lsp.config')
local configs = require('lsp.servers')
local merge_table = require('utils').merge_table
local lsp = vim.lsp

-- lsp-install
local function setup_servers()
  require('lspinstall').setup()

  local required_servers = {
    'bash',
    'css',
    'html',
    'json',
    'lua',
    'rust',
    'typescript',
    'vim',
    'efm',
    'graphql',
    'terraform',
  }

  -- get all installed servers
  local servers = require('lspinstall').installed_servers()
  for _, server in pairs(required_servers) do
    if not vim.tbl_contains(servers, server) then
      require('lspinstall').install_server(server)
    end
  end

  for _, server in pairs(servers) do
    local config = base_config()

    if configs[server] ~= nil then
      config = merge_table(config, configs[server])
    end

    require('lspconfig')[server].setup(config)
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require('lspinstall').post_install_hook = function()
  setup_servers() -- reload installed servers
  vim.cmd('bufdo e') -- this triggers the FileType autocmd that starts the server
end

lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
  underline = {
    severity_limit = 'Warning',
  },
  virtual_text = {
    prefix = '●',
    spacing = 2,
  },
  signs = {
    severity_limit = 'Warning',
  },
})
