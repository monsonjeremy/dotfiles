local present, cmp = pcall(require, 'cmp')
local present2, lspkind = pcall(require, 'lspkind')

if not (present or present2) then return end

--[[ compe.setup({
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'always',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,
  source = {
    calc = true,
    vsnip = { kind = '﬌' },
    nvim_lua = true,
    spell = true,
    tags = true,
    path = { kind = '  ' },
    buffer = { kind = ' ﬘ ', true },
    nvim_lsp = { kind = '  ' },
    treesitter = { kind = '  ' },
  },
}) ]]

local cmp = require'cmp'

cmp.setup({
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  formatting = {
   format = function(entry, vim_item)
      vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
      vim_item.menu = ({
        buffer = ' ﬘ ',
        path = '   ',
        nvim_lsp = '  ',
        treesitter = '  ',
        vsnip = ' ﬌ '
      })[entry.source.name]
      return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
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
  }
})
