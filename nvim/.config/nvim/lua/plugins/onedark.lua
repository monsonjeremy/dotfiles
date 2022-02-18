local M = {}

function M.setupOneDark()
  local present, onedark = pcall(require, 'onedark')
  if not present then
    return
  end

  onedark.setup({ hideInactiveStatusline = true, customTelescope = true })
end

return M
