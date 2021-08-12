local map = require('utils').map
local opts = {
  noremap = true,
  silent = true,
}

require('bufferline').setup({
  options = {
    buffer_close_icon = '',
    modified_icon = '',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 14,
    max_prefix_length = 13,
    tab_size = 20,
    enforce_regular_tabs = true,
    view = 'multiwindow',
    show_buffer_close_icons = true,
    separator_style = 'thin',
  },
})

map('n', '<S-t>', [[<Cmd>tabnew<CR>]], opts)
map('n', '<S-x>', [[<Cmd>bdelete<CR>]], opts)
map('n', '<TAB>', [[<Cmd>BufferLineCycleNext<CR>]], opts)
map('n', '<S-TAB>', [[<Cmd>BufferLineCyclePrev<CR>]], opts)
