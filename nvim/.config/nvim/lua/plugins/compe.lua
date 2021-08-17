local present, compe = pcall(require, 'compe')
if not present then return end

compe.setup({
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
})
