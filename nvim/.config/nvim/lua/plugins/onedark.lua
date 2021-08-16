local M = {}

function M.setupOneDark()
  require('onedark').setup({
    hideInactiveStatusline = true,
  })
end

return M
