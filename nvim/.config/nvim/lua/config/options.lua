-- vim.cmd('syntax on')

local opt = vim.opt
local g = vim.g

local py2_host = vim.fn.expand('~/.asdf/installs/python/2.7.18/bin/python')
if vim.fn.executable(py2_host) == 1 then
  g.python_host_prog = py2_host
else
  g.loaded_python_provider = 0
end

local py3_host = vim.fn.expand('~/.asdf/installs/python/3.9.5/bin/python')
if vim.fn.executable(py3_host) == 1 then
  g.python3_host_prog = py3_host
else
  local system_python3 = vim.fn.exepath('python3')
  if system_python3 ~= '' then
    g.python3_host_prog = system_python3
  end
end

g.loaded_perl_provider = 0

local function setup_clipboard()
  opt.clipboard = 'unnamedplus'

  if vim.fn.has('macunix') ~= 1 then
    return
  end

  local copy_argv = { 'pbcopy' }
  local paste_argv = { 'pbpaste' }

  if vim.env.TMUX and vim.fn.executable('reattach-to-user-namespace') == 1 then
    copy_argv = { 'reattach-to-user-namespace', 'pbcopy' }
    paste_argv = { 'reattach-to-user-namespace', 'pbpaste' }
  end

  vim.fn.system(paste_argv)
  if vim.v.shell_error == 0 then
    local copy_cmd = table.concat(copy_argv, ' ')
    local paste_cmd = table.concat(paste_argv, ' ')
    g.clipboard = {
      name = 'macOS-clipboard',
      copy = {
        ['+'] = copy_cmd,
        ['*'] = copy_cmd,
      },
      paste = {
        ['+'] = paste_cmd,
        ['*'] = paste_cmd,
      },
      cache_enabled = 0,
    }
    return
  end

  local ok, osc52 = pcall(require, 'vim.ui.clipboard.osc52')
  if ok then
    g.clipboard = {
      name = 'OSC52-fallback',
      copy = {
        ['+'] = osc52.copy('+'),
        ['*'] = osc52.copy('*'),
      },
      paste = {
        ['+'] = osc52.paste('+'),
        ['*'] = osc52.paste('*'),
      },
    }
  end
end

setup_clipboard()

opt.completeopt = 'menu,menuone,noselect'
opt.termguicolors = true
opt.wrap = false
opt.ruler = false
opt.ignorecase = true
opt.splitbelow = true
opt.splitright = true
opt.cul = true
opt.mouse = 'a'
opt.signcolumn = 'yes'
opt.cmdheight = 1
opt.updatetime = 200 -- update interval for gitsigns
opt.timeoutlen = 400
opt.scrolloff = 8
-- opt.lazyredraw = true
opt.linebreak = true
opt.textwidth = 100
opt.wildmenu = true
opt.showmatch = true
opt.conceallevel = 0 -- Show `` in markdown files
opt.smartcase = true
vim.opt.fillchars = {
  horiz = '━',
  horizup = '┻',
  horizdown = '┳',
  vert = '┃',
  vertleft = '┫',
  vertright = '┣',
  verthoriz = '╋',
}

-- Numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2

-- for indentline
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true

-- Backups
opt.backup = true
opt.writebackup = true
opt.backupdir = vim.fn.expand('~/.local/share/nvim/backup')
opt.backupskip = '/tmp/*,/private/tmp/*'
opt.directory = '~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp'
opt.swapfile = false
opt.undofile = true
opt.undodir = '~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp'

-- shortmess options
opt.shortmess:append('asI') -- disable intro

-- disable tilde on end of buffer:
vim.cmd('let &fcs=\'eob: \'')

local disabled_built_ins = {
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  'matchit',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end
