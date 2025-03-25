local present, cmp = pcall(require, 'cmp')
local present2, lspkind = pcall(require, 'lspkind')
local present3, luasnip = pcall(require, 'luasnip')
local present4, luasnipVscode = pcall(require, 'luasnip/loaders/from_vscode')

if not (present or present2 or present3 or present4) then
  return
end

cmp.setup({
  completion = { completeopt = 'menu,menuone,noinsert' },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      max_width = 50,
      symbol_map = { Copilot = '' },
    }),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-e>'] = cmp.mapping.close(),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
        fallback()
      end
    end, {
      'i',
      's',
    }),
    ['<Down>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    ['<Up>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
  },
  sources = {
    { name = 'copilot', group_index = 2 },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'spell' },
    { name = 'luasnip', option = { use_show_condition = false } },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'treesitter' },
    -- { name = 'rg' },
  },
})

luasnipVscode.lazy_load()
