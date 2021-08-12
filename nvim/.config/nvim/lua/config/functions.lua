local M = {}
local cmd = vim.api.nvim_exec

cmd(
  [[
    au TextYankPost * silent! lua require("vim.highlight").on_yank({ higroup = 'IncSearch', timeout = 300 })
  ]],
  false
)

cmd(
  [[
    au BufWritePre * %s/\s\+$//e
  ]],
  false
)

cmd(
  [[
    au BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
  ]],
  false
)

cmd(
  [[
    au BufWritePost *.vim :Reload
  ]],
  false
)

-- Set common config files as JSON
cmd(
  [[
    au BufNewFile,BufRead .eslintrc,.babelrc,.prettierrc,.nycrc set filetype=json
  ]],
  false
)

-- hide line numbers , statusline in specific buffers!
cmd(
  [[
    au TermOpen term://* setlocal nonumber laststatus=0 signcolumn=no
    au TermClose term://* bd!
    au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
  ]],
  false
)
