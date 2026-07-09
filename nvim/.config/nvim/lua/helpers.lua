local M = {}

function M.add(value, str, sep)
  sep = sep or ','
  str = str or ''
  value = type(value) == 'table' and table.concat(value, sep) or value
  return str ~= '' and table.concat({ value, str }, sep) or value
end

function M.concat(value)
  return table.concat(value)
end

-- Apply global options
function M.apply_options(opts)
  for k, v in pairs(opts) do
    vim.o[k] = v
  end
end

function M.apply_globals(globals)
  for k, v in pairs(globals) do
    vim.g[k] = v
  end
end

-- Map keys
function M.map(mode, key, fn, opts, desc)
  local options = {}

  if type(opts) == 'table' then
    options = vim.deepcopy(opts)
  elseif type(opts) == 'string' then
    desc = opts
  end

  if type(desc) == 'string' and desc ~= '' then
    options.desc = desc
  end

  vim.keymap.set(mode, key, fn, options)
end

-- Buffer local keymap
function M.buf_map(mode, key, fn, opts, desc)
  local options = {}

  if type(opts) == 'table' then
    options = vim.deepcopy(opts)
  elseif type(opts) == 'string' then
    desc = opts
  end

  if type(desc) == 'string' and desc ~= '' then
    options.desc = desc
  end

  if options.buffer == nil then
    options.buffer = vim.api.nvim_get_current_buf()
  end

  vim.keymap.set(mode, key, fn, options)
end

-- Buffer local option
function M.buf_option(...)
  vim.api.nvim_buf_set_option(vim.api.nvim_get_current_buf(), ...)
end

-- Check whether the current buffer is empty
function M.is_buffer_empty()
  return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

-- Check if the windows width is greater than a given number of columns
function M.has_width_gt(cols)
  return vim.fn.winwidth(0) / 2 > cols
end

function M.apply_colorscheme(name, mode)
  M.apply_options({ termguicolors = true, background = mode })

  M.apply_globals({ colors_name = name })

  vim.api.nvim_command('colorscheme ' .. name)
end

function M.merge_table(t1, t2)
  for k, v in pairs(t2) do
    t1[k] = v
  end
  return t1
end

return M
