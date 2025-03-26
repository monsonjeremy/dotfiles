local on_attach = require('lsp.on_attach')

-- config that activates keymaps and enables snippet support
local function base_config()
  return {
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

return base_config
