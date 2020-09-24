set nowrap                                      " do not wrap long lines by default
" set nocursorline                                " Don't highlight current cursor line
set path+=.
set wildignorecase                              " Case insensitive :search etc.
set wildmenu
set wildoptions=pum
set suffixesadd=.js,.jsx,.ts,.tsx               " Add suffix when looking for imported files
set include=from
set exrc                                        " Look for project specific settings in /project/.nvimrc
set secure                                      " Prevenr :autocmd unless owned by me
set spelllang=en_us
set mouse=a                                     " Enable mouse.
set lazyredraw                                  " Only redraw when needed
set nostartofline                               " Do not jump to first character with page commands.
set showmatch                                   " Highlight matching [{()}]
set completeopt=longest,menuone,preview
set clipboard=unnamedplus                       " Use the clipboard register
set list
set listchars=nbsp:¬,tab:>-,extends:»,precedes:«,trail:•
set noruler                                     " Show the cursor position all the time.
set noshowcmd                                   " Display incomplete commands.
set tildeop                                     " Enable ~ operator.
set timeoutlen=800                              " Timeout Leader after 400 ms.
set virtualedit=block                           " Enable virtualedit when in Visual Block mode.
set hidden                                      " Allow for unsaved changes when switchin buffers (use confirm if you want to be prompted for save)
set cmdheight=2                                 " Better display for messages
set shortmess+=c                                " don't give ins-completion-menu messages.
set nomodeline
set scrolloff=5
set autoread                                    " Automatically re-read file if a change was detected outside of vim
set fillchars+=vert:.                           " Change vertical split character to be a space (essentially hide it)
set noshowmode                                  " Don't dispay mode in command line (airilne already shows it)
set winbl=10                                    " Set floating window to be slightly transparent
set updatetime=300                              " You will have bad experience for diagnostic messages when it's default 4000.

" }}}
" Backup {{{
set backup                                      " Enable backup of files
set writebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set noswapfile

" }}}
" Undo {{{
set undofile                                    " Keep a persistent backup file.
set undodir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" }}}
" Folding {{{
set foldmethod=indent
set foldlevelstart=99
set foldnestmax=2
set foldtext=NeatFoldText()
" }}}
" Colors {{{
let g:onedark_terminal_italics=1
let g:dracula_colorterm=1
let g:onedark_hide_endofbuffer=1
let g:one_allow_italics=1
set background=dark
syntax on
set cursorline                                  " Disable Highlight current row
set termguicolors                               " Enable true color support
colorscheme onedark 


" }}}
" Tabs (whitespace settings) {{{
set tabstop=4                                   " Render Tabs using this many spaces.
set softtabstop=2
set expandtab                                   " Insert spaces when TAB is pressed.
set shiftwidth=2                                " Indentation amount for < and > commands.
set nojoinspaces                                " Prevents inserting two spaces after punctuation on a join (J).
set nrformats-=octal                            " Numbers that start with a zero will be considered to be octal
set smartindent
" }}}
" Line numbers {{{
set number                                      " Show line numbers
set relativenumber
set numberwidth=3                               " Gutter width for line numbers
set signcolumn=yes
"}}}
" Search {{{
set grepprg=ag\ --vimgrep
set ignorecase                                  " Make searching case insensitive.
set smartcase                                   " Use case sensitive search when query has mixed case.
set gdefault                                    " Use 'g' flag by default with :s/foo/bar/.
set omnifunc=syntaxcomplete#Complete
"}}}
" Substitute {{{
set inccommand=nosplit                          " Shows the effects of a command incrementally, as you type.
" }}}
" Splits {{{
set splitright                                  " Open vertical splits to the right
set splitbelow                                  " Open horizontal splits below
set diffopt+=vertical                           " Open diff in vertical split
set diffopt+=indent-heuristic
set diffopt+=algorithm:patience
"}}}
" Netrw {{{
let g:netrw_liststyle=4
let g:netrw_preview=1
let g:netrw_alto=0
let g:netrw_winsize=50
let g:netrw_keepdir=1
let g:netrw_menu=0
let g:netrw_banner=0
" Allow netrw to remove non-empty local directories
let g:netrw_localrmdir='rm -r'
let g:netrw_bufsettings='noma nomod nu nowrap ro nobl'
" }}}
" Tags {{{
set tags=./.tags,.tags;
" }}}

" Dim inactive buffer {{{
" Background colors for active vs inactive windows
" highlight ActiveWindow ctermbg=None ctermfg=None guibg=#282c34
" highlight InactiveWindow ctermbg=darkgray ctermfg=gray guibg=#27292e
" set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
" }}}

" Reload icons after init source
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Make background transparent for many things
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE
hi! LineNr ctermfg=NONE guibg=NONE
hi! SignColumn ctermfg=NONE guibg=NONE
hi! StatusLine guifg=#16252b guibg=#6699CC
hi! StatusLineNC guifg=#16252b guibg=#16252b

" Try to hide vertical spit and end of buffer symbol
hi! VertSplit gui=NONE guifg=#17252c guibg=#17252c
hi! EndOfBuffer ctermbg=NONE ctermfg=NONE guibg=#17252c guifg=#17252c

" Python 3 virtual env
let g:python_host_prog = '~/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '~/.pyenv/versions/neovim3/bin/python'

