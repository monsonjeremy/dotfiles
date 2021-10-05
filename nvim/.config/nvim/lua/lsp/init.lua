local present1, lspconfig = pcall(require, 'lspconfig')
local present2, lspinstall = pcall(require, 'lspinstall')
local present3, null_ls = pcall(require, 'null-ls')
if not (present1 or present2 or present3) then
  return
end

local base_config = require('lsp.config')
local configs = require('lsp.servers')
local merge_table = require('utils').merge_table
local lsp = vim.lsp

local buf_map = require('utils').buf_map
local buf_option = require('utils').buf_option

local opts = { noremap = true, silent = true }

require('null-ls').config({
  sources = {
    null_ls.builtins.formatting.prettierd.with({
      filetypes = { 'html', 'json', 'yaml', 'markdown', 'css', 'scss', 'gql' },
    }),
    null_ls.builtins.formatting.prismaFmt,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.stylua.with({
      extra_args = { '--config-path', vim.fn.expand('~/dotfiles/stylua.toml') },
    }),
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.trim_whitespace,
    null_ls.builtins.diagnostics.luacheck,
  },
})

-- lsp-install
local function setup_servers()
  lspinstall.setup()

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
  local servers = lspinstall.installed_servers()
  for _, server in pairs(required_servers) do
    if not vim.tbl_contains(servers, server) then
      lspinstall.install_server(server)
    end
  end

  for _, server in pairs(merge_table(servers, { 'null-ls' })) do
    local config = base_config()

    if configs[server] ~= nil then
      config = merge_table(config, configs[server])
    end

    lspconfig[server].setup(config)
  end
end

setup_servers()
vim.cmd('bufdo e')

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
lspinstall.post_install_hook = function()
  setup_servers() -- reload installed servers
  vim.cmd('bufdo e') -- this triggers the FileType autocmd that starts the server
end

lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
  underline = { severity_limit = 'Warning' },
  virtual_text = { prefix = '●', spacing = 2, severity_limit = 'Warning' },
  signs = { severity_limit = 'Warning' },
})

local function set_sign(type, icon)
  local sign = string.format('LspDiagnosticsSign%s', type)
  local texthl = string.format('LspDiagnosticsDefault%s', type)
  vim.fn.sign_define(sign, { text = icon, texthl = texthl })
end

set_sign('Hint', '')
set_sign('Information', '')
set_sign('Warning', ' ')
set_sign('Error', '')

-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _opts)
  if msg:match('exit code') then
    return
  end
  if log_level == vim.log.levels.ERROR then
    vim.api.nvim_err_writeln(msg)
  else
    vim.api.nvim_echo({ { msg } }, true, {})
  end
end
