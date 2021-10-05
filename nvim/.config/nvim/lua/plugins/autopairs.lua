local present1, autopairs = pcall(require, 'nvim-autopairs')
local present2, autopairs_completion = pcall(require, 'nvim-autopairs.completion.cmp')

if not (present1 or present2) then
  return
end

autopairs.setup({ check_ts = true })
autopairs_completion.setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
})
