local present, cmp = pcall(require, 'cmp')
local present2, lspkind = pcall(require, 'lspkind')
local present3, luasnip = pcall(require, 'luasnip')
local present4, luasnipVscode = pcall(require, 'luasnip/loaders/from_vscode')

if not (present or present2 or present3) then
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
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
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

if not present3 then
  return
end

luasnipVscode.lazy_load()
