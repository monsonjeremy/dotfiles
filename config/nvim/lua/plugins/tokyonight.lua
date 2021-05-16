-- vim.api.nvim_command[[
--   autocmd ColorScheme * highlight LspDiagnosticsVirtualTextError guifg=#db4b4b guibg=NONE"
--   autocmd ColorScheme * highlight LspDiagnosticsVirtualTextHint guifg=#1abc9c guibg=NONE"
--   autocmd ColorScheme * highlight LspDiagnosticsVirtualTextInformation guifg=#0db9d7 guibg=NONE"
--   autocmd ColorScheme * highlight LspDiagnosticsVirtualTextWarning guifg=#e0af68 guibg=NONE"

--   ]]

vim.cmd[[highlight LspDiagnosticsVirtualTextError guifg=#db4b4b guibg=NONE]]
vim.cmd[[highlight LspDiagnosticsVirtualTextHint guifg=#1abc9c guibg=NONE]]
vim.cmd[[highlight LspDiagnosticsVirtualTextInformation guifg=#0db9d7 guibg=NONE]]
vim.cmd[[highlight LspDiagnosticsVirtualTextWarning guifg=#e0af68 guibg=NONE]]

vim.cmd[[highlight LspDiagnosticsUnderlineError guisp=#db4b4b gui=underline]]
vim.cmd[[highlight LspDiagnosticsUnderlineHint guisp=NONE gui=underline]] -- #1abc9c
vim.cmd[[highlight LspDiagnosticsUnderlineInformation guisp=#0db9d7 gui=underline]]
vim.cmd[[highlight LspDiagnosticsUnderlineWarning guisp=#e0af68 gui=underline]]
