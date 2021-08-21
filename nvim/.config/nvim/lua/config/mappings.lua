local map = require('utils').map

local g = vim.g
g.mapleader = ' '

local opts = { noremap = true, silent = true }

-- general
map('n', '<Leader>bs', [[/<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>]])
map('v', 'X', [["_d]])

-- FZF
map('n', '<leader>fr', [[:RgRegex<CR>]], opts)
map('n', '<leader>fh', [[:History<CR>]], opts)

-- save
map('n', '<C-s>', [[ <Cmd> w <CR>]], opts)
map('n', '<Leader>ww',
    [[ oconst wait = (ms: number): Promise<void> => {<CR>return new Promise(res => setTimeout(res, ms));<CR>}<esc>k=i{<CR> ]],
    opts)

-- Search and replace under cursor
map('n', '<Leader>s', [[ :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left> ]], opts)

-- === Search shorcuts === "
map('n', '<C-_>', [[:nohlsearch<CR>]], opts)

map('n', '<leader>ga', [[:Git fetch --all<CR>]], opts)
map('n', '<leader>grum', [[:Git rebase upstream/master<CR>]], opts)
map('n', '<leader>grom', [[:Git rebase -i origin/master<CR>]], opts)

-- Vim Doge
map('n', '<Leader>z', [[:DogeGenerate<CR>]], opts)

map('n', '<Space>', [[<Nop>]], opts)
map('n', '<leader>ve', [[:vsplit $MYVIMRC<CR>]], opts)
map('i', 'jj', [[<Esc>]], opts)

-- Yank to end of line
map('n', 'Y', 'y$', opts)

-- Yank all matches
map('n', '<leader>Y', [[:CopyMatches<CR>]], opts)

-- Close and update buffer
map('n', '<leader>q', [[ZZ<C-w><C-p>]], opts)

map('n', '<leader>e', [[:e<CR>]], opts)

-- Escape to clear highlighting in normal mode
map('n', '<Esc>', [[:nohlsearch<CR>]], opts)

-- Macros
-- Run macro over selected rows using @
vim.cmd([[
  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction
]])
map('x', '@', [[:<C-u>call ExecuteMacroOverVisualRange()<CR>]], opts)

-- Movement
-- Move to end of line
map('n', 'L', [[$]], opts)
map('v', 'L', [[$]], opts)
map('o', 'L', [[$]], opts)

-- Move to start of line
map('n', 'H', [[^]], opts)
map('v', 'H', [[^]], opts)
map('o', 'H', [[^]], opts)

-- Terminal
-- Escape to exit to normal mode in terminal
map('t', '<Esc>', [[<C-\><C-n>]], opts)
map('t', 'jj', [[<C-\><C-n>]], opts)

-- Substitute
map('n', 'c*', [[*``cgn]], opts)
map('n', 'c#', [[*``cgN]], opts)
map('n', 'd*', [[*``dgn]], opts)
map('n', 'd#', [[*``dgN]], opts)

map('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Delete current visual selection and dump in black hole buffer before pasting
map('v', '<leader>p', [["_dP]], opts)

map('n', '<leader>y', [["+y]], opts)
map('v', '<leader>y', [["+y]], opts)

map('n', '<leader>Y', [[gg"+yG]], opts)

map('n', '<leader>d', [[_d]], opts)
map('v', '<leader>d', [[_d]], opts)
map('n', ',', [[<PageDown>]], opts)
map('n', '-', [[<PageUp>]], opts)

map('n', '<Leader>tt', [[:ToggleTerm<CR>]], opts)

-- Telescope
map('n', '<C-p>', [[:Telescope find_files hidden=true<CR>]], opts)
map('n', '<leader>p', [[:Telescope buffers <CR>]], opts)
map('n', '<leader>ff', [[:Telescope live_grep<CR>]], opts)

-- Hop
map('n', '<leader>hw', [[:HopWord<cr>]], opts)
map('n', '<leader>h', [[:HopLine<cr>]], opts)

map('n', '<S-t>', [[<Cmd>tabnew<CR>]], opts)
map('n', '<S-x>', [[<Cmd>bdelete<CR>]], opts)
map('n', '<TAB>', [[<Cmd>BufferLineCycleNext<CR>]], opts)
map('n', '<S-TAB>', [[<Cmd>BufferLineCyclePrev<CR>]], opts)

map('n', '<Leader>sp', [[:lua require('spectre').open()<CR>]], opts)
map('n', '<Leader>so', [[:lua require('spectre').show_options()<CR>]], opts)
map('n', '<Leader>spf', [[:lua require('spectre').open_file_search()<CR>]], opts)
map('v', '<Leader>sp', [[:lua require('spectre').open_visual()<CR>]], opts)

map('n', '<Leader>n', [[:NvimTreeToggle<CR>]], opts)
map('n', '<Leader>r', [[:NvimTreeRefresh<CR>]], opts)
map('n', '<Leader>f', [[:NvimTreeFindFile<CR>]], opts)

map('v', '∆', [[<Plug>MoveBlockDown]], { noremap = false, silent = false })
map('v', '˚', [[<Plug>MoveBlockUp]], { noremap = false, silent = false })
map('n', '∆', [[<Plug>MoveLineDown]], { noremap = false, silent = false })
map('n', '˚', [[<Plug>MoveLineUp]], { noremap = false, silent = false })

vim.cmd(
  'silent! command PackerCompile lua require(\'plugins\') require(\'packer\').compile()')
vim.cmd(
  'silent! command PackerInstall lua require(\'plugins\') require(\'packer\').install()')
vim.cmd(
  'silent! command PackerStatus lua require(\'plugins\') require(\'packer\').status()')
vim.cmd('silent! command PackerSync lua require(\'plugins\') require(\'packer\').sync()')
vim.cmd(
  'silent! command PackerUpdate lua require(\'plugins\') require(\'packer\').update()')

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.completions()', { expr = true })

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
map('n', '<C-h>', [[:call WinMove('h')<CR>]], opts)
map('n', '<C-j>', [[:call WinMove('j')<CR>]], opts)
map('n', '<C-k>', [[:call WinMove('k')<CR>]], opts)
map('n', '<C-l>', [[:call WinMove('l')<CR>]], opts)

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

map('v', '/',
    [[:<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0 | exec '/'.g:srchstr | endif<CR>]],
    opts)
map('v', '?',
    [[:<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0 | exec '?'.g:srchstr | endif<CR>]],
    opts)