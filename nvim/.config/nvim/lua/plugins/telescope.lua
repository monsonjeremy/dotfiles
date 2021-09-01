local present, telescope = pcall(require, 'telescope')
if not present then return end

telescope.setup({
  defaults = {
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '--fixed-strings',
    },
    prompt_prefix = '   ',
    layout_config = { prompt_position = 'top' },
    sorting_strategy = 'ascending',
    file_ignore_patterns = { 'node_modules', '.git/', 'terraform.tfstate' },
  },
})
