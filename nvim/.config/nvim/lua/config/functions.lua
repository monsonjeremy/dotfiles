local cmd = vim.api.nvim_exec2

vim.cmd('silent! command LazySync lua require(\'plugins\') require(\'lazy\').sync()')
vim.cmd([[silent! command Neogen lua require('neogen').generate()]])

-- Run macro over selected rows using @
vim.cmd([[
  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction
]])

vim.api.nvim_create_augroup('JeremyCustom', {})
vim.api.nvim_create_augroup('JeremyFT', {})

vim.api.nvim_create_autocmd('BufEnter', {
  group = 'JeremyCustom',
  pattern = '*',
  callback = function(args)
    vim.opt.formatoptions = vim.opt.formatoptions - { 'o' }
    vim.bo[args.buf].formatexpr = nil
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  group = 'JeremyCustom',
  pattern = '*',
  callback = function()
    vim.go.laststatus = 3
  end,
  once = true,
})

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
