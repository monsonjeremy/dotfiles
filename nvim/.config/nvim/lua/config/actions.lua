local M = {}

-- Execute a macro across the current visual range, preserving the classic @ workflow.
function M.execute_macro_over_visual_range()
  local register = vim.fn.getcharstr()
  if not register or register == '' then
    return
  end

  vim.api.nvim_echo({ { '@' .. register, 'Normal' } }, false, {})
  vim.cmd(('\'<,\'>normal @%s'):format(register))
end

-- Move to a neighboring split, creating one if it doesn't exist.
function M.move_window(direction)
  if not direction or direction == '' then
    return
  end

  local current_win = vim.api.nvim_get_current_win()
  vim.cmd.wincmd(direction)

  if vim.api.nvim_get_current_win() ~= current_win then
    return
  end

  if direction == 'j' or direction == 'k' then
    vim.cmd.split()
  else
    vim.cmd.vsplit()
  end

  vim.cmd.wincmd(direction)
end

return M
