local present, nvimtree = pcall(require, 'nvim-tree')
if not present then
  return
end

nvimtree.setup({
  update_cwd = true,
  auto_close = true,
  lsp_diagnostics = true,
  view = {
    -- width of the window, can be either a number (columns) or a string in `%`
    width = 25,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
  },
})
