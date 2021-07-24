local M = {}
local utils = require('utils')

function M.setupOneDark()

  require('onedark').setup({
    hideInactiveStatusline = true
  })

  utils.apply_colorscheme("onedark", "dark")
end

return M
