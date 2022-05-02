local on_attach = require('lsp.on_attach')
local lsp = vim.lsp

-- config that activates keymaps and enables snippet support
local function base_config()
  local capabilities = require('cmp_nvim_lsp').update_capabilities(
    lsp.protocol.make_client_capabilities()
  )

  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' },
  }

  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

return base_config
