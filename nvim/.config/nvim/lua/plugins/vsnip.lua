vim.g.vsnip_filetypes = { typescriptreact = { 'typescript' } }

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

-- tab completion

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t('<C-n>')
  elseif check_back_space() then
    return t('<Tab>')
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t('<C-p>')
  elseif vim.fn.call('vsnip#jumpable', { -1 }) == 1 then
    return t('<Plug>(vsnip-jump-prev)')
  else
    return t('<S-Tab>')
  end
end

function _G.completions()
  local npairs = require('nvim-autopairs')
  if vim.fn.pumvisible() == 1 then
    if vim.fn.complete_info()['selected'] ~= -1 then
      return vim.fn['compe#confirm']('<CR>')
    end
  end
  return npairs.autopairs_cr()
end

-- require('compe').register_source('vsnip', require('compe_vsnip'))