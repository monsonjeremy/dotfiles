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
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.b._copilot_suggestion ~= nil then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes(vim.fn['copilot#Accept'](), true, true, true),
          ''
        )
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
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
    { name = 'rg' },
  },
})
