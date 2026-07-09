return {
  {
    dir = vim.fn.expand('~/Desktop/nvim-plugin-use'),
    name = 'plugin-use-tracker.nvim',
    lazy = false,
    enabled = function()
      local has_local_plugin = vim.fn.isdirectory(vim.fn.expand('~/Desktop/nvim-plugin-use')) == 1
      local has_ui = #vim.api.nvim_list_uis() > 0
      return has_local_plugin and has_ui
    end,
  },
}
