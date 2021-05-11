local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
      options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

-- save
map("n", "<C-s>", [[ <Cmd> w <CR>]], opt)

-- Wait snippet
map("n", "<Leader>ww", [[ oconst wait = (ms: number): Promise<void> => {<CR>return new Promise(res => setTimeout(res, ms));<CR>}<esc>k=i{<CR> ]], opt)

-- Search and replace under cursor
map("n", "<Leader>s", [[ :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left> ]], opt)

map("n", "<C-h>", [[:call WinMove('h')<CR>]], { noremap=true, silent=true })
map("n", "<C-j>", [[:call WinMove('j')<CR>]], { noremap=true, silent=true })
map("n", "<C-k>", [[:call WinMove('k')<CR>]], { noremap=true, silent=true })
map("n", "<C-l>", [[:call WinMove('l')<CR>]], { noremap=true, silent=true })
map("n", "<C-w>f", [[:vertical wincmd f<CR>]], { noremap=true, silent=true })

-- Comments
map("n", "<leader>/", [[:CommentToggle<CR>]], {noremap = true, silent = true})
map("v", "<leader>/", [[:CommentToggle<CR>]], {noremap = true, silent = true})

-- === Search shorcuts === "
map("n", "<C-_>", [[:nohlsearch<CR>]], {noremap = true, silent = true})

