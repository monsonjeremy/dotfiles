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
      symbol_map = { Copilot = '' },
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
      -- local copilot_keys = vim.fn['copilot#Accept']()
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      -- elseif copilot_keys ~= '' and type(copilot_keys) == 'string' then
      --   vim.api.nvim_feedkeys(copilot_keys, 'i', true)
      else
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
    { name = 'copilot' },
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

-- cmp.event:on('menu_opened', function()
--   vim.b.copilot_suggestion_hidden = true
-- end)
--
-- cmp.event:on('menu_closed', function()
--   vim.b.copilot_suggestion_hidden = false
-- end)

if not present3 then
  return
end

luasnipVscode.lazy_load()
