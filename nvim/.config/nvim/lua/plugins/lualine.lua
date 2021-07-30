require('lualine').setup({
  options = {
    -- theme = 'tokyonight',
    theme = 'onedark',
  },
  sections = {
    lualine_c = {
      {
        'diagnostics',
        sources = { 'nvim_lsp' },
      },
      { 'filename' },
    },
  },
})
