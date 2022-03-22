local present1 = pcall(require, 'lspconfig')
local present2, lspinstall = pcall(require, 'nvim-lsp-installer')
local present3, lsp_installer_servers = pcall(require, 'nvim-lsp-installer.servers')
if not (present1 or present2 or present3) then
  return
end

local base_config = require('lsp.config')
local configs = require('lsp.servers')
require('lsp.status')

local function auto_install_servers()
  local required_servers = {
    'bashls',
    'cssls',
    'html',
    'jsonls',
    'sumneko_lua',
    'rust_analyzer',
    'tsserver',
    'vimls',
    'graphql',
    'terraformls',
    'prismals',
    'elixirls',
    'dockerls',
    'stylelint_lsp',
    'eslint',
    'cssmodules_ls',
  }

  for _, name in pairs(required_servers) do
    local ok, server = lsp_installer_servers.get_server(name)
    -- Check that the server is supported in nvim-lsp-installer
    if ok then
      if not server:is_installed() then
        server:install()
      end
    end
  end
end

auto_install_servers()

lspinstall.on_server_ready(function(server)
  local config = configs[server.name]
  server:setup(config or base_config())
  vim.cmd([[ do User LspAttachBuffers ]])
end)

vim.cmd('bufdo e')
