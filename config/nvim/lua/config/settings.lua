local apply_options = require('utils').apply_options
local apply_globals = require('utils').apply_globals
local add = require('utils').add
local concat = require('utils').concat

apply_globals({
  mapleader = " ",
  python_host_prog = '~/.pyenv/versions/neovim2/bin/python',
  python3_host_prog = '~/.pyenv/versions/neovim3/bin/python',
  indentLine_char = '│',
  indentLine_first_char = '│',
  indentLine_showFirstIndentLevel = 1,
})

apply_options({
  nowrap = true,                                  -- do not wrap long lines by default
  path = vim.opt.path .. ".",
  wildignorecase = true,                          -- Case insensitive :search etc.
  wildmenu = true,
  wildoptions = vim.opt.wildoptions .. "pum",
  suffixesadd = vim.opt.suffixesadd .. ".js,.jsx,.ts,.tsx",
  include = "from",
  exrc = true,                                    -- Look for project specific settings in /project/.nvimrc
  secure = true,                                  -- Prevenr :autocmd unless owned by me
  spelllang = "en_us",
  mouse = "a",                                    -- Enable mouse.
  lazyredraw = true,                              -- Only redraw when needed
  nostartofline = true,                           -- Do not jump to first character with page commands.
  showmatch = true,                               -- Highlight matching [{()}]
  completeopt = "menuone,noselect",
  clipboard = "unnamedplus",                      -- Use the clipboard register
  list = true,
  listchars = "nbsp:¬,tab:>-,extends:»,precedes:«,trail:•",
  ler = true,                                     -- Show the cursor position all the time.                           -- Display incomplete commands.
  tildeop = true,                                 -- Enable ~ operator.
  timeoutlen = "800",                             -- Timeout Leader after 400 ms.
  virtualedit = "block",                          -- Enable virtualedit when in Visual Block mode.
  hidden = true,                                   -- Allow for unsaved changes when switchin buffers (use confirm if you want to be prompted for save)
  shortmess = vim.opt.shortmess .. "c",        -- don't give ins-completion-menu messages.
  nomodeline = true,
  scrolloff = 5,
  autoread = true,                                -- Automatically re-read file if a change was detected outside of vim
  noshowmode = true,                              -- Don't dispay mode in command line (airilne already shows it)
  winbl = "10",                                   -- Set floating window to be slightly transparent
  updatetime = "100",                             -- You will have bad experience for diagnostic messages when it's default 4000.
  cmdheight = "2",                                -- Give more space for displaying messages.
  backup = true,                                  -- Enable backup of files
  writebackup = true,
  backupdir = "~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp",
  backupskip = "/tmp/*,/private/tmp/*",
  directory = "~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp",
  noswapfile = true,
  undofile = true,                                -- Keep a persistent backup file.
  undodir = "~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp",
  foldmethod = "indent",
  foldlevelstart = "99",
  foldnestmax = "2",
  foldtext = "NeatFoldText()",
  tabstop = "4",                                  -- Render Tabs using this many spaces.
  softtabstop = "2",
  expandtab = true,                               -- Insert spaces when TAB is pressed.
  shiftwidth = "2",                               -- Indentation amount for < and > commands.
  nojoinspaces = true,                            -- Prevents inserting two spaces after punctuation on a join (J).
  smartindent = true,
  number = true,                                  -- Show line numbers
  relativenumber = true,
  signcolumn = "yes",
  grepprg = "ag\" --vimgrep",
  ignorecase = true,                              -- Make searching case insensitive.
  smartcase = true,                               -- Use case sensitive search when query has mixed case.
  gdefault = true,                                -- Use 'g' flag by default with :s/foo/bar/.
  inccommand = "nosplit",                         -- Shows the effects of a command incrementally, as you type.
  splitright = true,                              -- Open vertical splits to the right
  splitbelow = true,                              -- Open horizontal splits below
  diffopt = vim.opt.diffopt .. "vertical,indent-heuristic,algorithm:patience",                -- Open diff in vertical split
  tags="./.tags,.tags;"
})


