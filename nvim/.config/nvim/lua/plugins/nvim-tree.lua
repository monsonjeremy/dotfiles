local present, nvimtree = pcall(require, 'nvim-tree')
if not present then
  return
end

nvimtree.setup({
  update_cwd = true,
  diagnostics = {
    enable = true,
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
    highlight_git = true,
    root_folder_modifier = ':t',
    highlight_opened_files = 'all',
    indent_markers = {
      enable = false,
    },
    special_files = {
      'README.md',
      'Makefile',
      'MAKEFILE',
      'package.json',
      '.gitignore',
      '.env',
    },
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = false,
        git = false,
      },
      glyphs = {

        default = '',
        symlink = '',
        folder = {
          open = '',
          default = '',
          -- default = '',
          -- open = '',
          empty = '',
          empty_open = '',
          symlink = '',
          symlink_open = '',
        },
      },
    },
  },
  filters = {
    dotfiles = false,
    custom = {
      '.git$',
      '.cache',
      'node_modules',
      '_build',
      'deps',
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

local function git_mv(old_name, new_name)
  local cmd = string.format('git mv %s %s', old_name, new_name)
  local result = vim.fn.system(cmd)

  if vim.v.shell_error ~= 0 then
    print('Error renaming file: ' .. result)
  else
    print('File renamed successfully')
  end
end

local function git_rename_file()
  local node = require('nvim-tree.lib').get_node_at_cursor()
  if not node then
    print('No file selected')
    return
  end
  local old_name = node.absolute_path
  local new_name = vim.fn.input('New name: ', old_name)
  if new_name == '' or new_name == old_name then
    print('Rename cancelled')
    return
  end
  git_mv(old_name, new_name)
end

_G.git_rename_file = git_rename_file

vim.api.nvim_set_keymap(
  'n',
  '<leader>gr',
  ':lua git_rename_file()<CR>',
  { noremap = true, silent = true }
)
