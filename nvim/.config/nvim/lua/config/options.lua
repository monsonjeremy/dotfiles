-- vim.cmd('syntax on')

local opt = vim.opt
local g = vim.g

g['python_host_prog'] = vim.env.HOME .. '/.asdf/installs/python/2.7.18/bin/python'
g['python3_host_prog'] = vim.env.HOME .. '/.asdf/installs/python/3.9.5/bin/python'
g['copilot_no_tab_map'] = true
g['copilot_assume_mapped'] = true
g['copilot_tab_fallback'] = true

g.do_filetype_lua = 1
g.did_load_filetypes = 0
g.loaded_perl_provider = 0

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
opt.updatetime = 250 -- update interval for gitsigns
opt.timeoutlen = 400
opt.clipboard = 'unnamedplus'
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

-- g.nvim_tree_git_hl = 1
-- g.nvim_tree_root_folder_modifier = ':t'
g.nvim_tree_allow_resize = 1
-- g.nvim_tree_highlight_opened_files = 1
-- g.nvim_tree_show_icons = { git = 0, folders = 1, files = 1 }
-- g.nvim_tree_special_files = { 'README.md', 'Makefile', 'MAKEFILE', 'package.json', '.env' }
-- g.nvim_tree_icons = {
--   default = '',
--   symlink = '',
--   folder = {
--     open = '',
--     default = '',
--     -- default = '',
--     -- open = '',
--     empty = '',
--     empty_open = '',
--     symlink = '',
--     symlink_open = '',
--   },
--   lsp = { hint = '', info = '', warning = '', error = '' },
-- }

-- suppress error messages from lang servers
-- vim.notify = require('notify')

local hl = function(group, opts)
  opts.default = true
  vim.api.nvim_set_hl(0, group, opts)
end

-- Misc {{{
hl('@comment', { link = 'Comment' })
-- hl('@error', {link = 'Error'})
hl('@none', { bg = 'NONE', fg = 'NONE' })
hl('@preproc', { link = 'PreProc' })
hl('@define', { link = 'Define' })
hl('@operator', { link = 'Operator' })
-- }}}

-- Punctuation {{{
hl('@punctuation.delimiter', { link = 'Delimiter' })
hl('@punctuation.bracket', { link = 'Delimiter' })
hl('@punctuation.special', { link = 'Delimiter' })
-- }}}

-- Literals {{{
hl('@string', { link = 'String' })
hl('@string.regex', { link = 'String' })
hl('@string.escape', { link = 'SpecialChar' })
hl('@string.special', { link = 'SpecialChar' })

hl('@character', { link = 'Character' })
hl('@character.special', { link = 'SpecialChar' })

hl('@boolean', { link = 'Boolean' })
hl('@number', { link = 'Number' })
hl('@float', { link = 'Float' })
-- }}}

-- Functions {{{
hl('@function', { link = 'Function' })
hl('@function.call', { link = 'Function' })
hl('@function.builtin', { link = 'Special' })
hl('@function.macro', { link = 'Macro' })

hl('@method', { link = 'Function' })
hl('@method.call', { link = 'Function' })

hl('@constructor', { link = 'Special' })
hl('@parameter', { link = 'Identifier' })
-- }}}

-- Keywords {{{
hl('@keyword', { link = 'Keyword' })
hl('@keyword.function', { link = 'Keyword' })
hl('@keyword.operator', { link = 'Keyword' })
hl('@keyword.return', { link = 'Keyword' })

hl('@conditional', { link = 'Conditional' })
hl('@repeat', { link = 'Repeat' })
hl('@debug', { link = 'Debug' })
hl('@label', { link = 'Label' })
hl('@include', { link = 'Include' })
hl('@exception', { link = 'Exception' })
-- }}}

-- Types {{{
hl('@type', { link = 'Type' })
hl('@type.builtin', { link = 'Type' })
hl('@type.qualifier', { link = 'Type' })
hl('@type.definition', { link = 'Typedef' })

hl('@storageclass', { link = 'StorageClass' })
hl('@attribute', { link = 'PreProc' })
hl('@field', { link = 'Identifier' })
hl('@property', { link = 'Function' })
-- }}}

-- Identifiers {{{
hl('@variable', { link = 'Normal' })
hl('@variable.builtin', { link = 'Special' })

hl('@constant', { link = 'Constant' })
hl('@constant.builtin', { link = 'Special' })
hl('@constant.macro', { link = 'Define' })

hl('@namespace', { link = 'Include' })
hl('@symbol', { link = 'Identifier' })
-- }}}

-- Text {{{
hl('@text', { link = 'Normal' })
hl('@text.strong', { bold = true })
hl('@text.emphasis', { italic = true })
hl('@text.underline', { underline = true })
hl('@text.strike', { strikethrough = true })
hl('@text.title', { link = 'Title' })
hl('@text.literal', { link = 'String' })
hl('@text.uri', { link = 'Underlined' })
hl('@text.math', { link = 'Special' })
hl('@text.environment', { link = 'Macro' })
hl('@text.environment.name', { link = 'Type' })
hl('@text.reference', { link = 'Constant' })

hl('@text.todo', { link = 'Todo' })
hl('@text.note', { link = 'SpecialComment' })
hl('@text.warning', { link = 'WarningMsg' })
hl('@text.danger', { link = 'ErrorMsg' })
-- }}}

-- Tags {{{
hl('@tag', { link = 'Tag' })
hl('@tag.attribute', { link = 'Identifier' })
hl('@tag.delimiter', { link = 'Delimiter' })
-- }}}
