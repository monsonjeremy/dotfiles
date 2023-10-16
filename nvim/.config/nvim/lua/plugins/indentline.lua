local present, indentBlankline = pcall(require, 'ibl')
if not present then
  return
end

indentBlankline.setup({
  -- char = '│',
  indent = {
    char = '▏',
  },
  -- show_first_indent_level = false,
  exclude = {
    filetypes = { 'help', '', 'alpha' },
    buftypes = {
      'nofile',
      'terminal',
      'WhichKey',
      'dashboard',
      'alpha',
      'help',
      'TelescopePrompt',
    },
  },
  scope = { enabled = true },
  -- show_current_context_start = true,
})
