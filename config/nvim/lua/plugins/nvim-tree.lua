local map = require('utils').map
local g = vim.g
local opts = {
  noremap = true,
  silent = true
}

g.nvim_tree_side = "left"
g.nvim_tree_width = 26
g.nvim_tree_ignore = {".git", "node_modules", ".cache"}
g.nvim_tree_auto_open = 0
g.nvim_tree_auto_close = 1
g.nvim_tree_quit_on_open = 0
g.nvim_tree_follow = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_hide_dotfiles = 0
g.nvim_tree_git_hl = 1
g.nvim_tree_root_folder_modifier = ":t"
g.nvim_tree_tab_open = 0
g.nvim_tree_allow_resize = 1

g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1
}

map("n", "<Leader>n", [[:NvimTreeToggle<CR>]], opts)
map("n", "<Leader>r", [[:NvimTreeRefresh<CR>]], opts)
map("n", "<Leader>f", [[:NvimTreeFindFile<CR>]], opts)
