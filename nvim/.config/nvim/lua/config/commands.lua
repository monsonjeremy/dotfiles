vim.api.nvim_create_user_command('LazySync', function()
  require('lazy').sync()
end, { desc = 'Sync plugins with lazy.nvim' })

vim.api.nvim_create_user_command('Browse', 'exe "!open . <args>"', {
  nargs = 1,
  desc = 'Open a path in Finder',
})
