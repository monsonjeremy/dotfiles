local present, telescope = pcall(require, 'telescope')

if not present then
  return
end

local default = {
  pickers = {
    find_files = {
      -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
      find_command = { 'rg', '--files', '--hidden', '--follow' },
    },
  },
  defaults = {
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
      '--follow',
    },
    file_ignore_patterns = {
      'node_modules',
      '.git/',
      'terraform.tfstate',
      'deps',
      '_build',
      '.elixir_ls',
    },
    prompt_prefix = '   ',
    selection_caret = '  ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    path_display = { 'truncate' },
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown({}),
      },
    },
  },
}

local M = {}

M.setup = function(override_flag)
  if override_flag then
    default = require('core.utils').tbl_override_req('telescope', default)
  end

  telescope.setup(default)

  local extensions = { 'ui-select' }

  for _, ext in ipairs(extensions) do
    -- print('loading extension: ' .. ext)
    telescope.load_extension(ext)
  end
end

M.setup()
