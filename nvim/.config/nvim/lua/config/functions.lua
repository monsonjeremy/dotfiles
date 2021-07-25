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

-- Set common config files as JSON
vim.cmd[[
au BufNewFile,BufRead .eslintrc,.babelrc,.prettierrc,.nycrc set filetype=json
]]

-- hide line numbers , statusline in specific buffers!
vim.api.nvim_exec([[
  au TermOpen term://* setlocal nonumber laststatus=0 signcolumn=no
  au TermClose term://* bd!
  au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
]], false)
