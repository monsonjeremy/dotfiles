
require "bufferline".setup({
    options = {
        buffer_close_icon = "",
        modified_icon = "",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 20,
        enforce_regular_tabs = true,
        view = "multiwindow",
        show_buffer_close_icons = true,
        separator_style = "thin"
    },
})

local opt = {silent = true}

local map = vim.api.nvim_set_keymap
vim.g.mapleader = " "

--command that adds new buffer and moves to it
map("n", "<S-t>", [[<Cmd>tabnew<CR>]], opt)

--removing a buffer
map("n", "<S-x>", [[<Cmd>bdelete<CR>]], opt)

-- tabnew and tabprev
map("n", "<TAB>", [[<Cmd>BufferLineCycleNext<CR>]], opt)
map("n", "<S-TAB>", [[<Cmd>BufferLineCyclePrev<CR>]], opt)
