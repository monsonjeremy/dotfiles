local cmd = vim.api.nvim_exec

vim.cmd('silent! command PackerCompile lua require(\'plugins\') require(\'packer\').compile()')
vim.cmd('silent! command PackerInstall lua require(\'plugins\') require(\'packer\').install()')
vim.cmd('silent! command PackerStatus lua require(\'plugins\') require(\'packer\').status()')
vim.cmd('silent! command PackerSync lua require(\'plugins\') require(\'packer\').sync()')
vim.cmd('silent! command PackerUpdate lua require(\'plugins\') require(\'packer\').update()')

-- Run macro over selected rows using @
vim.cmd([[
  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction
]])

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

-- Set common config files as JSON
cmd(
  [[
    au BufNewFile,BufRead .eslintrc,.babelrc,.prettierrc,.nycrc set filetype=json
  ]],
  false
)

vim.cmd([[
  function! RangeSearch(direction)
    call inputsave()
    let g:srchstr = input(a:direction)
    call inputrestore()
    if strlen(g:srchstr) > 0
      let g:srchstr = g:srchstr.'\%>'.(line("'<")-1).'l'.'\%<'.(line("'>")+1).'l'
    else
      let g:srchstr = ''
    endif
  endfunction
]])

vim.cmd([[
  " Create and move to split
  " Check if a split already exists in the direction you want to move to.
  " If it does, the function simply moves the focus to that split.
  " If there isn’t a split already, the function creates a new split and
  " moves the focus to that split
  function! WinMove(key)
    let t:curwin = winnr()
    execute "wincmd ".a:key
    if (t:curwin == winnr())
      if (match(a:key,'[jk]'))
        wincmd v
      else
        wincmd s
      endif
      execute "wincmd ".a:key
    endif
  endfunction
]])
