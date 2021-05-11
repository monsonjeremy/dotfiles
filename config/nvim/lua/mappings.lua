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
