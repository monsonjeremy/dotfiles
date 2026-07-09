local on_attach = require('lsp.on_attach')

local capabilities = vim.lsp.protocol.make_client_capabilities()
local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if status_ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end
local lsp_capabilities = capabilities

-- config that activates keymaps and enables snippet support
local function base_config()
  return {
    capabilities = lsp_capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

return base_config
