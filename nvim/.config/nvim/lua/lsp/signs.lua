local function set_sign(type, icon)
  local sign = string.format('LspDiagnosticsSign%s', type)
  local texthl = string.format('LspDiagnosticsDefault%s', type)
  vim.fn.sign_define(sign, { text = icon, texthl = texthl })
end

set_sign('Hint', '')
set_sign('Information', '')
set_sign('Warning', ' ')
set_sign('Error', 'ﰸ')
