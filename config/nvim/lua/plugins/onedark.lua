local M = {}

function M.setupOneDark()
  local utils = require('utils')

  utils.apply_globals({
    onedark_hide_inactive_statusline = true,
  })

  vim.defer_fn(function ()
    vim.cmd[[highlight LspDiagnosticsVirtualTextError guifg=#db4b4b guibg=NONE]]
    vim.cmd[[highlight LspDiagnosticsVirtualTextHint guifg=#1abc9c guibg=NONE]]
    vim.cmd[[highlight LspDiagnosticsVirtualTextInformation guifg=#0db9d7 guibg=NONE]]
    vim.cmd[[highlight LspDiagnosticsVirtualTextWarning guifg=#e0af68 guibg=NONE]]

    vim.cmd[[highlight LspDiagnosticsUnderlineError guisp=#db4b4b gui=undercurl]]
    vim.cmd[[highlight LspDiagnosticsUnderlineHint guisp=NONE gui=undercurl]] -- #1abc9c
    vim.cmd[[highlight LspDiagnosticsUnderlineInformation guisp=#0db9d7 gui=undercurl]]
    vim.cmd[[highlight LspDiagnosticsUnderlineWarning guisp=#e0af68 gui=undercurl]]
  end, 15)
end

return M
