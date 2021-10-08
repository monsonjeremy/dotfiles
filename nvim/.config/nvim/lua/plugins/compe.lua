local present, cmp = pcall(require, 'cmp')
local present2, lspkind = pcall(require, 'lspkind')

if not (present or present2) then
  return
end

cmp.setup({
  completion = { completeopt = 'menu,menuone,noinsert' },
  formatting = {
    format = lspkind.cmp_format({
      with_text = false,
      --[[ menu = {
        buffer = ' ﬘ ',
        path = '   ',
        nvim_lsp = '  ',
        treesitter = '  ',
        vsnip = ' ﬌ ',
      }, ]]
    }),
  },
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` user.
    end,
  },
  mapping = {
    ['<C-e>'] = cmp.mapping.close(),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'spell' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'treesitter' },
  },
})
