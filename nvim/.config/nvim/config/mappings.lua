
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

-- Vim Doge
map("n", "<Leader>z", [[:DogeGenerate<CR>]], opts)
