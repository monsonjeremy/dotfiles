local present, indentBlankline = pcall(require, 'indent_blankline')
if not present then
  return
end

indentBlankline.setup({
  -- char = '│',
  char = '▏',
  show_first_indent_level = false,
  filetype_exclude = { 'help', 'packer', '', 'alpha' },
  buftype_exclude = {
    'nofile',
    'terminal',
    'WhichKey',
    'dashboard',
    'alpha',
    'help',
    'packer',
    'TelescopePrompt',
  },
  show_current_context = true,
  -- show_current_context_start = true,
  show_trailing_blankline_indent = false,
})
