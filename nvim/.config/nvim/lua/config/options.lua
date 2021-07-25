vim.cmd "syntax on"

local opt = vim.opt
local g = vim.g

g["python_host_prog"] = '~/.asdf/installs/python/2.7.18/bin/python'
g["python3_host_prog"] = '~/.asdf/installs/python/3.9.5/bin/python'

opt.completeopt = 'menuone,noselect'
opt.termguicolors = true
opt.wrap = false
opt.ruler = false
opt.hidden = true
opt.ignorecase = true
opt.splitbelow = true
opt.splitright = true
opt.cul = true
opt.mouse = "a"
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.updatetime = 250 -- update interval for gitsigns
opt.timeoutlen = 400
opt.clipboard = "unnamedplus"
opt.scrolloff = 3
opt.lazyredraw = true
opt.linebreak = true
opt.textwidth = 100
opt.wildmenu = true
opt.inccommand = 'nosplit'
opt.showmatch = true

-- Numbers
opt.number = false
opt.numberwidth = 2

-- for indentline
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true

-- shortmess options
opt.shortmess:append("asI") --disable intro

-- disable tilde on end of buffer:
vim.cmd("let &fcs='eob: '")

local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end
