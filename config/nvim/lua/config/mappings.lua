
local map = require('utils').map

local g = vim.g
g.mapleader = " "
local opts = {
  noremap = true,
  silent = true
}

-- general
map("n", "<Leader>bs", [[/<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>]])
map("v", "X", [["_d]])

-- FZF
map("n", "<C-p>", [[:call FZFWithDevIcons()<CR>]], opts)
map("n", "<leader>p", [[:Buffers<CR>]], opts)
map("n", "<leader>fp", [[:Telescope find_files<CR>]], opts)
map("n", "<leader>fp", [[:Telescope find_files<CR>]], opts)
map("n", "<leader>ff", [[:RG<CR>]], opts)
map("n", "<leader>fr", [[:RgRegex<CR>]], opts)
map("n", "<leader>fh", [[:History<CR>]], opts)

-- save
map("n", "<C-s>", [[ <Cmd> w <CR>]], opts)
map("n", "<Leader>ww", [[ oconst wait = (ms: number): Promise<void> => {<CR>return new Promise(res => setTimeout(res, ms));<CR>}<esc>k=i{<CR> ]], opts)

-- Search and replace under cursor
map("n", "<Leader>s", [[ :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left> ]], opts)

map("n", "<C-h>", [[:call WinMove('h')<CR>]], opts)
map("n", "<C-j>", [[:call WinMove('j')<CR>]], opts)
map("n", "<C-k>", [[:call WinMove('k')<CR>]], opts)
map("n", "<C-l>", [[:call WinMove('l')<CR>]], opts)
map("n", "<C-w>f", [[:vertical wincmd f<CR>]], opts)

-- === Search shorcuts === "
map("n", "<C-_>", [[:nohlsearch<CR>]], opts)

map("n", "<leader>ga", [[:Git fetch --all<CR>]], opts)
map("n", "<leader>grum", [[:Git rebase upstream/master<CR>]], opts)
map("n", "<leader>grom", [[:Git rebase -i origin/master<CR>]], opts)

-- LSP
map('n', '<leader>dd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
map('n', '<leader>df', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
map('n', '<leader>dt', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
map('n', '<leader>dr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
map('n', '<leader>drr', '<cmd>Lspsaga rename<CR><CR>', opts)
map('n', '<leader>pd', '<cmd>Lspsaga preview_definition<CR>', opts)
map('n', '<leader>sh', '<cmd>Lspsaga signature_help<CR>', opts)
map('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
map('n', '<leader>cs', '<cmd>lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>', opts)
map('n', '<leader>dn', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
map('n', '<leader>dp', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
map('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts)
map('n', '<leader>fo', '<cmd>lua vim.lsp.buf.formatting_sync(nil, 1000)<CR>', opts)
map('v', '<leader>ca', '<cmd><C-U>Lspsaga range_code_action<CR>', opts)

-- Nvim Tree
map("n", "<Leader>n", [[:NvimTreeToggle<CR>]], opts)
map("n", "<Leader>r", [[:NvimTreeRefresh<CR>]], opts)
map("n", "<Leader>f", [[:NvimTreeFindFile<CR>]], opts)

-- Vim Doge
map("n", "<Leader>z", [[:DogeGenerate<CR>]], opts)

-- Buffer line
map("n", "<S-t>", [[<Cmd>tabnew<CR>]], opts)
map("n", "<S-x>", [[<Cmd>bdelete<CR>]], opts)
map("n", "<TAB>", [[<Cmd>BufferLineCycleNext<CR>]], opts)
map("n", "<S-TAB>", [[<Cmd>BufferLineCyclePrev<CR>]], opts)

map("v", "∆", [[<Plug>MoveBlockDown]], { noremap = false, silent = false })
map("v", "˚", [[<Plug>MoveBlockUp]], { noremap = false, silent = false })
map("n", "∆", [[<Plug>MoveLineDown]], { noremap = false, silent = false })
map("n", "˚", [[<Plug>MoveLineUp]], { noremap = false, silent = false })
