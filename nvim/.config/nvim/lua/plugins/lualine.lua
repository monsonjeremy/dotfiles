local present, lualine = pcall(require, 'lualine')
if not present then return end

lualine.setup({
  options = { theme = 'onedark' },
  sections = { lualine_c = { { 'diagnostics', sources = { 'nvim_lsp' } }, { 'filename' } } },
})
