local lspinstall = require('lspinstall')

lspinstall.setup()

local required_servers = {
  "bash",
  "css",
  "html",
  "json",
  "lua",
  "rust",
  "typescript",
  "vim"
}

local installed_servers = require'lspinstall'.installed_servers()
for _, server in pairs(required_servers) do
  if not vim.tbl_contains(installed_servers, server) then
    require'lspinstall'.install_server(server)
  end
end
