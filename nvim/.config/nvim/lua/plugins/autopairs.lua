local present1, autopairs = pcall(require, 'nvim-autopairs')

if not present1 then
  return
end

autopairs.setup({ check_ts = true })

-- autopairs_completion.setup({
--   map_cr = true, --  map <CR> on insert mode
--   map_complete = true, -- it will auto insert `(` after select function or method item
--   auto_select = true, -- automatically select the first item
--   insert = false, -- use insert confirm behavior instead of replace
--   map_char = { -- modifies the function or method delimiter by filetypes
--     all = '(',
--     tex = '{',
--   },
-- })
