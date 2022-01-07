local present, treesitter = pcall(require, 'nvim-treesitter.configs')
if not present then
  return
end

treesitter.setup({
  autopairs = { enable = true },
  autotag = {
    enable = true,
    filetypes = {
      'html',
      'javascript',
      'javascriptreact',
      'typescriptreact',
      'svelte',
      'vue',
      'heex',
    },
  },
  rainbow = { enable = true, extended_mode = false, max_file_lines = 2000 },
  ensure_installed = 'maintained',
  highlight = { enable = true, use_languagetree = true },
  refactor = { highlight_definitions = { enable = true }, navigation = { enable = true } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
  },
})
