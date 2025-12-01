local on_attach = require('lsp.on_attach')

local lsp_capabilities = require('blink.cmp').get_lsp_capabilities() -- Angepasst für blink.cmp

-- config that activates keymaps and enables snippet support
local function base_config()
  return {
    capabilities = lsp_capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

return base_config
