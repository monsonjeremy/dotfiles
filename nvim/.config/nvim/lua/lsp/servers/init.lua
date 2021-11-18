local M = {}

M.bash = require('lsp.servers.bash')
M.css = require('lsp.servers.css')
M.html = require('lsp.servers.html')
M.json = require('lsp.servers.json')
M.lua = require('lsp.servers.lua')
M.rust = require('lsp.servers.rust')
M.typescript = require('lsp.servers.typescript')
M.vim = require('lsp.servers.vim')
M.terraform = require('lsp.servers.terraform')

print('loading LSP')
-- Not yet supported by lspinstall
require('lsp.servers.prisma')
require('lsp.servers.null-ls.init')

return M
