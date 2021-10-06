vim.g.tokyonight_style = 'storm'
vim.g.tokyonight_hide_inactive_statusline = true

vim.defer_fn(function()
  vim.cmd([[highlight DiagnosticsVirtualTextError guifg=#db4b4b guibg=NONE]])
  vim.cmd([[highlight DiagnosticsVirtualTextHint guifg=#1abc9c guibg=NONE]])
  vim.cmd([[highlight DiagnosticsVirtualTextInformation guifg=#0db9d7 guibg=NONE]])
  vim.cmd([[highlight DiagnosticsVirtualTextWarning guifg=#e0af68 guibg=NONE]])

  vim.cmd([[highlight DiagnosticsUnderlineError guisp=#db4b4b gui=undercurl]])
  vim.cmd([[highlight DiagnosticsUnderlineHint guisp=NONE gui=undercurl]]) -- #1abc9c
  vim.cmd([[highlight DiagnosticsUnderlineInformation guisp=#0db9d7 gui=undercurl]])
  vim.cmd([[highlight DiagnosticsUnderlineWarning guisp=#e0af68 gui=undercurl]])
end, 1)
