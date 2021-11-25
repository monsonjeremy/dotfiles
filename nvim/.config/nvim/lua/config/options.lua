-- vim.cmd('syntax on')

local opt = vim.opt
local g = vim.g

g['python_host_prog'] = vim.env.HOME .. '/.asdf/installs/python/2.7.18/bin/python'
g['python3_host_prog'] = vim.env.HOME .. '/.asdf/installs/python/3.9.5/bin/python'
g['copilot_no_tab_map'] = true
g['copilot_assume_mapped'] = true

g.did_load_filetypes = true

opt.completeopt = 'menu,menuone,noselect'
opt.termguicolors = true
opt.wrap = false
opt.ruler = false
opt.hidden = true
opt.ignorecase = true
opt.splitbelow = true
opt.splitright = true
opt.cul = true
opt.mouse = 'a'
opt.signcolumn = 'yes'
opt.cmdheight = 1
opt.updatetime = 250 -- update interval for gitsigns
opt.timeoutlen = 400
opt.clipboard = 'unnamedplus'
opt.scrolloff = 8
opt.lazyredraw = true
opt.linebreak = true
opt.textwidth = 100
opt.wildmenu = true
opt.inccommand = 'nosplit'
opt.showmatch = true
opt.conceallevel = 0 -- Show `` in markdown files
opt.smartcase = true

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
opt.backupdir = '~/.local/share/nvim/backup'
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

-- g.nvim_tree_ignore = { '.git', '.cache' }
g.nvim_tree_gitignore = 1
g.nvim_tree_quit_on_open = 0
g.nvim_tree_indent_markers = 1
-- g.nvim_tree_hide_dotfiles = 0
g.nvim_tree_git_hl = 1
g.nvim_tree_root_folder_modifier = ':t'
g.nvim_tree_allow_resize = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_show_icons = { git = 0, folders = 1, files = 1 }
g.nvim_tree_special_files = { 'README.md', 'Makefile', 'MAKEFILE', 'package.json', '.env' }
g.nvim_tree_icons = {
  default = '',
  symlink = '',
  folder = {
    open = '',
    default = '',
    -- default = '',
    -- open = '',
    empty = '',
    empty_open = '',
    symlink = '',
    symlink_open = '',
  },
  lsp = { hint = '', info = '', warning = '', error = '' },
}
