local present, catppuccin = pcall(require, 'catppuccin')
if not present then
  return
end

catppuccin.setup({
  flavour = 'macchiato',
  background = { -- :h background
    light = 'latte',
    dark = 'mocha',
  },
  show_end_of_buffer = false, -- show the '~' characters after the end of buffers
  dim_inactive = {
    enabled = true,
    shade = 'dark',
    percentage = 0.15,
  },
  styles = {
    comments = { 'italic' },
    conditionals = { 'italic' },
    loops = { 'italic' },
    functions = { 'bold' },
    keywords = { 'bold' },
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = { 'bold' },
    operators = {},
  },
  integrations = {
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    cmp = true,
    dashboard = true,
    gitsigns = true,
    lsp_saga = true,
    noice = true,
    nvimtree = true,
    telescope = true,
    treesitter = true,
    treesitter_context = true,
    rainbow_delimiters = true,
    notify = true,
    lsp_trouble = true,
    mini = true,
    bufferline = true,
    which_key = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { 'italic' },
        hints = { 'italic' },
        warnings = { 'italic' },
        information = { 'italic' },
      },
      underlines = {
        errors = { 'undercurl' },
        hints = { 'undercurl' },
        warnings = { 'undercurl' },
        information = { 'undercurl' },
      },
    },
  },
})

vim.cmd.colorscheme('catppuccin')
