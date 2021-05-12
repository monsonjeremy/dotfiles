require'lspinstall'.setup()

local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    require'lspconfig'[server].setup{}
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end


local function on_attach(client)
  require 'illuminate'.on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

local lspconfig = require("lspconfig")

lspconfig.tsserver.setup{
  on_attach= function(client)
    client.resolved_capabilities.document_formatting = false
    on_attach(client)
  end,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
}

lspconfig.rust_analyzer.setup{
  on_attach= function(client)
    client.resolved_capabilities.document_formatting = false
    on_attach(client)
  end,
  capabilities=capabilities
}

lspconfig.yamlls.setup {on_attach = on_attach}
lspconfig.cssls.setup {on_attach = on_attach}
lspconfig.html.setup {on_attach = on_attach}
lspconfig.bashls.setup {on_attach = on_attach}
lspconfig.dockerls.setup {on_attach = on_attach}
lspconfig.cssls.setup {on_attach = on_attach}
lspconfig.pyls.setup{ on_attach=on_attach }
lspconfig.dotls.setup{ on_attach=on_attach }
lspconfig.terraformls.setup{ on_attach=on_attach }
lspconfig.vimls.setup{ on_attach=on_attach}
lspconfig.jsonls.setup {
  on_attach=on_attach,
  cmd = {"json-languageserver", "--stdio"}
}
