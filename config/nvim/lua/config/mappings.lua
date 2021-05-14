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


-- === Search shorcuts === "
map("n", "<C-_>", [[:nohlsearch<CR>]], {noremap = true, silent = true})

-- LSP
local cmd = vim.cmd
cmd "let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']"

cmd "nnoremap <leader>dd :lua vim.lsp.buf.definition()<CR>"
cmd "nnoremap <leader>df :lua vim.lsp.buf.implementation()<CR>"
cmd "nnoremap <leader>dt :lua vim.lsp.buf.signature_help()<CR>"
cmd "nnoremap <leader>dr :lua vim.lsp.buf.references()<CR>"
cmd "nnoremap <leader>drr :Lspsaga rename<CR><CR>"
cmd "nnoremap <silent> <leader>pd :Lspsaga preview_definition<CR>"
cmd "nnoremap <leader>sh :Lspsaga signature_help<CR>"
cmd "nnoremap <silent> K :Lspsaga hover_doc<CR>"
cmd "nnoremap <leader>cs :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>"
cmd "nnoremap <leader>dn :Lspsaga diagnostic_jump_next<CR>"
cmd "nnoremap <leader>dp :Lspsaga diagnostic_jump_prev<CR>"
cmd "nnoremap <silent><leader>ca :Lspsaga code_action<CR>"
cmd "vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>"
