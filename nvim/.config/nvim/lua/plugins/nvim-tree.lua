local present, nvimtree = pcall(require, 'nvim-tree')
if not present then
  return
end

nvimtree.setup({
  update_cwd = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
  actions = {
    open_file = {
      quit_on_open = false,
    },
  },
  view = {
    -- width of the window, can be either a number (columns) or a string in `%`
    width = 25,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
  },
  renderer = {
    indent_markers = {
      enable = false,
    },
  },
  filters = {
    dotfiles = false,
    custom = {
      '.git',
      '.cache',
      'node_modules',
      '_build',
      'deps',
      'priv',
    },
  },
  git = {
    ignore = false,
  },
})

-- Quit Neovim If NvimTree is last buffer
vim.api.nvim_create_autocmd('BufEnter', {
  nested = true,
  callback = function()
    if vim.fn.winnr('$') == 1 and vim.fn.bufname() == ('NvimTree_' .. vim.fn.tabpagenr()) then
      vim.cmd('quit')
    end
  end,
})
