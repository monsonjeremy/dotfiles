
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.config/nvim/plugged')

" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" === Syntax Highlighting === "
Plug 'chriskempson/base16-vim'
Plug 'folke/lsp-colors.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neoclide/jsonc.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'heavenshell/vim-jsdoc'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'cespare/vim-toml'

" Commands
Plug 'tpope/vim-eunuch'

Plug 'APZelos/blamer.nvim'
Plug 'Raimondi/delimitMate'
Plug 'RRethy/vim-illuminate'
Plug 'easymotion/vim-easymotion'
Plug 'AndrewRadev/dsf.vim'
Plug 'dsznajder/vscode-es7-javascript-react-snippets', { 'do': 'yarn install --frozen-lockfile && yarn compile' }

" Editor
Plug 'kkoomen/vim-doge'
Plug 'matze/vim-move'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Colorscheme
Plug 'joshdick/onedark.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter-refactor'

Plug 'voldikss/vim-floaterm'
Plug 'chaoren/vim-wordmotion'

" === Initialize plugin system === "
call plug#end()

" Plugin settings

" Editing {{{
nnoremap <leader>bs /<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>
vnoremap X "_d                                                        " Delete line to black hole register
vnoremap <leader>p "_dP
"}}}

" Indent Guides {{{
" let g:indentLine_char = '┊'
let g:indentLine_char = ''
let g:indentLine_first_char = ''
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0
" }}
" }}}

" Blamer nvim {{{
let g:blamer_enabled = 0
let g:blamer_prefix = ' > '
" }}}

" Hexokinase {{{
let g:Hexokinase_highlighters = [ 'virtual' ]
" }}}

" Coc.nvim {{{


" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHold * :call <SID>show_hover_doc()
autocmd CursorHoldI * :call <SID>show_hover_doc()


let g:coc_snippet_next = '<tab>'
let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-prettier', 'coc-html', 'coc-css', 'coc-eslint', 'coc-snippets']

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"           " Use enter to confirm complete

nmap <silent> <leader>dp <Plug>(coc-diagnostic-prev)                    " Use `[c` and `]c` for navigate diagnostics
nmap <silent> <leader>dn <Plug>(coc-diagnostic-next)                    " Use `[c` and `]c` for navigate diagnostics
nmap <silent> <leader>ca <Plug>(coc-codeaction)                          "
nmap <silent> <leader>qf <Plug>(coc-fix-current)                          "
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dt <Plug>(coc-type-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>df <Plug>(coc-implementation)

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif           " Close preview window when completion is done.
set statusline^=%{coc#status()}                                         " Add status line support, for integration with other plugin, checkout `:h coc-status`
command! -nargs=0 Format :call CocAction('format')                      " Use `:Format` to format current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)                " Use `:Fold` for fold current buffer

augroup coc
  autocmd!
  " autocmd CursorHold * silent call CocActionAsync('highlight')                                " Highlight symbol under cursor on CursorHold
  autocmd FileType typescript,json,javascript setl formatexpr=CocAction('formatSelected')     " Setup formatexpr specified filetype(s).
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')                    " Update signature help on jump placeholder
augroup end
augroup coc
  autocmd!
  " Highlight symbol under cursor on CursorHold
   autocmd CursorHold * silent call CocActionAsync('highlight')
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json,javascript setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd FileType markdown :call CocDisable()
augroup end

" Using CocList
nnoremap <silent> <leader>cd  :<C-u>CocList diagnostics<cr>  " Show all diagnostics
nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>     " Show commands
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>   " Search workspace symbols
nnoremap <silent> <leader>cp  :<C-u>CocList outline<cr>      " Outline document
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>

" coc.nvim color changes
hi! link CocErrorSign WarningMsg
hi! link CocWarningSign Number
hi! link CocInfoSign Type
" }}}

" vim-better-whitespace {{{
nmap <leader>y :StripWhitespace<CR>                              "   <leader>y - Automatically remove trailing whitespace
" }}}

" vim-jsdoc shortcuts {{{
nmap <leader>z :JsDoc<CR>                                        " Generate jsdoc for function under cursor
" }}}

" NERDTree {{{
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$'] " Hide certain files and directories from NERDTree
let g:NERDTreeShowHidden = 1                                                                          " Show hidden files/directories
let g:NERDTreeMinimalUI = 1                                                                           " Remove bookmarks and help text from NERDTree
let g:NERDTreeDirArrowExpandable = '⬏'                                                                " Custom icons for expandable/expanded directories
let g:NERDTreeDirArrowCollapsible = '⬎'
nmap <leader>n :NERDTreeToggle<CR>                                                                    "  <leader>n - Toggle NERDTree on/off
nmap <leader>f :NERDTreeFind<CR>                                                                      "  <leader>f - Opens current file location in NERDTree
noremap , <PageDown>                                                                                  "   ,       - PageDown
noremap - <PageUp>                                                                                    "   -       - PageUp

" Customize NERDTree directory
hi! NERDTreeCWD guifg=#99c794
" }}}

" Vim airline {{{
" Wrap in try/catch to avoid errors on initial install before plugin is available
try
let g:airline_theme='tokyonight'
let g:airline_extensions = ['branch', 'hunks', 'coc']                                         " Enable extensions
let g:airline_section_z = airline#section#create(['linenr'])                                  " Update section z to just have line number
let g:airline_skip_empty_sections = 1                                                         " Do not draw separators for empty sections (only for the active window) >
let g:airline#extensions#coc#enabled = 1                                                    " Enable COC Airline
let g:airline#extensions#tabline#formatter = 'unique_tail'                                    " Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]   " Custom setup that removes filetype/whitespace from default vim airline bar
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'    " Configure error/warning section to use coc.nvim
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
let g:NERDTreeStatusline = ''                                                                 " Hide the Nerdtree status line to avoid clutter
let g:airline_exclude_preview = 1                                                             " Disable vim-airline in preview mode
let g:airline_powerline_fonts = 1                                                             " Enable powerline fonts
let g:airline_highlighting_cache = 1                                                          " Enable caching of syntax highlighting groups
let g:airline#extensions#hunks#enabled=0                                                      " Don't show git changes to current file in airline
if !exists('g:airline_symbols')                                                               " Define custom airline symbols
  let g:airline_symbols = {}
endif

catch
  echo 'Airline not installed. It should work after running :PlugInstall'
endtry

" vim-javascript {{{
let g:javascript_plugin_jsdoc = 1                     " Enable syntax highlighting for JSDoc
" }}}

" Auto Close Tag {{{
let g:closetag_shortcut = '>'                         " Shortcut for closing tags, default is '>'
let g:closetag_close_shortcut = '<leader>>'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js'
let g:closetag_filetypes = 'html,xhtml,phtml,js,ts'
let g:closetag_xhtml_filetypes = 'xhtml,jsx,js'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'javascript': 'jsxRegion',
    \ 'javascript.js': 'jsxRegion',
    \ }

" Rainbox Parens {{{
let g:rainbow_active = 1                "set to 0 if you want to enable it later via :RainbowToggle
" }}}

" Vim Move {{{
let g:move_map_keys = 0
vmap ∆ <Plug>MoveBlockDown
vmap ˚ <Plug>MoveBlockUp
nmap ∆ <Plug>MoveLineDown
nmap ˚ <Plug>MoveLineUp
" }}}
"

" Git {{{
nnoremap <leader>gc :GBranches<CR>
nnoremap <leader>ga :Git fetch --all<CR>
nnoremap <leader>grum :Git rebase upstream/master<CR>
nnoremap <leader>grom :Git rebase origin/master<CR>
" }}}

lua <<EOF
require("lsp-colors").setup {
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
}

require("trouble").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
  refactor = {
    highlight_definitions = { enable = true },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
      },
    },
  },
}
EOF

