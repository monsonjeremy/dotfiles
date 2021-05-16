vim.cmd[[
au TextYankPost * silent! lua require("vim.highlight").on_yank({ higroup = 'IncSearch', timeout = 300 })
]]

vim.cmd[[
au BufWritePre * %s/\s\+$//e
]]

vim.cmd[[
au BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
]]

vim.cmd[[
au BufWritePost *.vim :Reload
]]

vim.cmd[[
au TermOpen * setlocal nonumber | setlocal signcolumn=no
]]
