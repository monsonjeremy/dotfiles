local cmd = vim.cmd

cmd "syntax on"
cmd "set background=dark"
cmd "set cursorline"
cmd "set termguicolors"

local base16 = require('base16')
base16(base16.themes.onedark, true)

-- Color for the floating windows
cmd "highlight NormalFloat cterm=NONE ctermfg=168 ctermbg=236 gui=NONE guifg=#fff guibg=#24283b"

cmd "hi DiffAdd guifg=#10B981 guibg=none"
cmd "hi DiffChange guifg=#61afef guibg=none"
cmd "hi DiffModified guifg=#61afef guibg=none"
cmd "hi DiffDelete guifg=#db4b4b guibg=none"

-- line n.o
cmd "hi clear CursorLine"
cmd "hi cursorlinenr guifg=#abb2bf"

-- NvimTree
cmd "hi NvimTreeFolderIcon guifg = #61afef"
cmd "hi NvimTreeFolderName guifg = #61afef"
cmd "hi NvimTreeIndentMarker guifg=#383c44"
cmd "hi NvimTreeNormal guibg=#1e222a"
cmd "hi NvimTreeVertSplit guifg=#1e222a"
cmd "hi NvimTreeRootFolder guifg=#f9929b"

cmd "hi NvimInternalError guifg=#f9929b"
cmd "hi Comment guifg=#42464e"

cmd "hi NvimInternalError guifg=#f9929b"

cmd "hi EndOfBuffer guifg=#1e222a"

-- Transparent
cmd "hi Normal ctermbg=NONE guibg=NONE"
cmd "hi NonText ctermbg=NONE guibg=#1e222a guifg=#1e222a"
cmd "hi LineNr ctermfg=NONE guibg=NONE"
cmd "hi SignColumn ctermfg=NONE guibg=NONE"

-- " Try to hide vertical split and end of buffer symbol
cmd "hi VertSplit gui=NONE guifg=#383c44 guibg=#1e222a"

-- Highlight trailing whitespaces
cmd "hi Trail ctermbg=red guibg=red"
cmd "call matchadd('Trail', '\\s\\+$', 100)"

-- inactive statuslines as thin splitlines
cmd "highlight! StatusLineNC gui=underline guifg=#383c44 guibg=NONE"

-- error / warnings
cmd "hi LspDiagnosticsSignError guifg=#f9929b"
cmd "hi LspDiagnosticsVirtualTextError guifg=#BF616A"
cmd "hi LspDiagnosticsSignWarning guifg=#EBCB8B"
cmd "hi LspDiagnosticsVirtualTextWarning guifg=#EBCB8B"

-- info
cmd "hi LspDiagnosticsSignInformation guifg=#A3BE8C"
cmd "hi LspDiagnosticsVirtualTextInformation guifg=#A3BE8C"

-- hint
cmd "hi LspDiagnosticsSignHint guifg=#61afef"
cmd "hi LspDiagnosticsVirtualTextHint guifg=#61afef"

require('colorizer').setup()

require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#61afef",
  Hint = "#10B981"
})
