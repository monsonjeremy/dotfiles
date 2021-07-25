" set nowrap                                      "  do not wrap long lines by default
" set path+=.
" set wildignorecase                              "  Case insensitive :search etc.
" set wildmenu
" set wildoptions=pum
" set suffixesadd=.js,.jsx,.ts,.tsx               "  Add suffix when looking for imported files
" set include=from
" set exrc                                        "  Look for project specific settings in /project/.nvimrc
" set secure                                      "  Prevenr :autocmd unless owned by me
" set spelllang=en_us
" set mouse=a                                     "  Enable mouse.
" set lazyredraw                                  "  Only redraw when needed
" set nostartofline                               "  Do not jump to first character with page commands.
" set showmatch                                   "  Highlight matching [{()}]
" set completeopt=menuone,noselect
" set clipboard=unnamedplus                       "  Use the clipboard register
" set list
" set listchars=nbsp:¬,tab:>-,extends:»,precedes:«,trail:•
" set noruler                                     "  Show the cursor position all the time.
" set noshowcmd                                   "  Display incomplete commands.
" set tildeop                                     "  Enable ~ operator.
" set timeoutlen=800                              "  Timeout Leader after 400 ms.
" set virtualedit=block                           "  Enable virtualedit when in Visual Block mode.
" set hidden                                      "  Allow for unsaved changes when switchin buffers (use confirm if you want to be prompted for save)
" set cmdheight=1                                 "  Better display for messages
" set shortmess+=c                                "  don't give ins-completion-menu messages.
" set nomodeline
" set scrolloff=5
" set autoread                                    "  Automatically re-read file if a change was detected outside of vim
" set noshowmode                                  "  Don't dispay mode in command line (airilne already shows it)
" set winbl=10                                    "  Set floating window to be slightly transparent
" set updatetime=100                              "  You will have bad experience for diagnostic messages when it's default 4000.
" set backup                                      "  Enable backup of files
" set writebackup
" set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" set backupskip=/tmp/*,/private/tmp/*
" set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" set noswapfile
" set undofile                                    "  Keep a persistent backup file.
" set undodir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" set foldmethod=indent
" set foldlevelstart=99
" set foldnestmax=2
" " set foldtext=NeatFoldText()
" set tabstop=4                                   "  Render Tabs using this many spaces.
" set softtabstop=2
" set expandtab                                   "  Insert spaces when TAB is pressed.
" set shiftwidth=2                                "  Indentation amount for < and > commands.
" set nojoinspaces                                "  Prevents inserting two spaces after punctuation on a join (J).
" set nrformats-=octal                            "  Numbers that start with a zero will be considered to be octal
" set smartindent
" set number                                      "  Show line numbers
" set relativenumber
" set signcolumn=yes
" set grepprg=ag\ " vimgrep
" set ignorecase                                  "  Make searching case insensitive.
" set smartcase                                   "  Use case sensitive search when query has mixed case.
" set gdefault                                    "  Use 'g' flag by default with :s/foo/bar/.
" set inccommand=nosplit                          "  Shows the effects of a command incrementally, as you type.
" set splitright                                  "  Open vertical splits to the right
" set splitbelow                                  "  Open horizontal splits below
" set diffopt+=vertical                           "  Open diff in vertical split
" set diffopt+=indent-heuristic
" set diffopt+=algorithm:patience
" set tags=./.tags,.tags;
