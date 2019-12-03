" check whether vim-plug is installed and install it if necessary
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

Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Shougo/echodoc.vim'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'heavenshell/vim-jsdoc'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Plug 'Shougo/denite.nvim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Colorscheme
Plug 'joshdick/onedark.vim'

" === Syntax Highlighting === "
Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim', { 'for': ['ts', 'tsx'] }

" === Initialize plugin system === "
call plug#end()

" Plugin settings

" FZF Fuzzyfinder {{{
let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse --margin=1,2'
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

nnoremap <silent> <C-p> :call FZFWithDevIcons()<CR>
"nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <leader>p :Buffers<CR>
nnoremap <silent> <leader>ff :Rg<CR>
nnoremap <silent> <leader>fc :History:<CR>
nnoremap <silent> <leader>fh :History<CR>
nnoremap <silent> <leader>fg :Rg <C-R><C-W><CR>
inoremap <silent> <c-space> <esc>:Snippets<CR>

imap <c-f> <plug>(fzf-complete-path)
imap <c-l> <plug>(fzf-complete-line)

" }}}

" Coc.nvim {{{
function! s:check_back_space() abort                                    " use <tab> for trigger completion and navigate to next complete item
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

nnoremap <silent> K :call <SID>show_documentation()<CR>                 " Use K for show documentation in preview window
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"           " Use enter to confirm complete
nmap <silent> [c <Plug>(coc-diagnostic-prev)                            " Use `[c` and `]c` for navigate diagnostics
nmap <silent> ]c <Plug>(coc-diagnostic-next)                            " Use `[c` and `]c` for navigate diagnostics
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dt <Plug>(coc-type-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif           " Close preview window when completion is done.
command! -nargs=0 Format :call CocAction('format')                      " Use `:Format` to format current buffer
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}     " Add status line support, for integration with other plugin, checkout `:h coc-status`
let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-prettier', 'coc-html', 'coc-ultisnips', 'coc-css', 'coc-eslint', 'coc-tslint', 'coc-tslint-plugin']

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup coc
  autocmd!
  autocmd CursorHold * silent call CocActionAsync('highlight')                                " Highlight symbol under cursor on CursorHold
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
augroup end

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Using CocList
nnoremap <silent> <leader>cd  :<C-u>CocList diagnostics<cr>  " Show all diagnostics
nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>     " Show commands
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>   " Search workspace symbols
nnoremap <silent> <leader>cp  :<C-u>CocList outline<cr>      " Outline document

" coc.nvim color changes
hi! link CocErrorSign WarningMsg
hi! link CocWarningSign Number
hi! link CocInfoSign Type
" }}}

" NeoSnippet {{{
imap <C-k> <Plug>(neosnippet_expand_or_jump)                     " Map <C-k> as shortcut to activate snippet if available
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory='~/.config/nvim/snippets'    " Load custom snippets from snippets folder
let g:neosnippet#enable_conceal_markers = 0                      " Hide conceal markers
" }}}

" vim-better-whitespace {{{
nmap <leader>y :StripWhitespace<CR>                              "   <leader>y - Automatically remove trailing whitespace
" }}}

" vim-commentary {{{
nmap g/ gc
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
let g:airline_theme='onedark'
let g:airline_extensions = ['branch', 'hunks', 'coc']                                         " Enable extensions
let g:airline_section_z = airline#section#create(['linenr'])                                  " Update section z to just have line number
let g:airline_skip_empty_sections = 1                                                         " Do not draw separators for empty sections (only for the active window) >
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

" echodoc {{{
let g:echodoc#enable_at_startup = 1                   " Enable echodoc on startup
" }}}

" vim-javascript {{{
let g:javascript_plugin_jsdoc = 1                     " Enable syntax highlighting for JSDoc
" }}}

" Signify {{{
let g:signify_sign_delete = '-'

" Make background color transparent for git changes
hi! SignifySignAdd guibg=NONE
hi! SignifySignDelete guibg=NONE
hi! SignifySignChange guibg=NONE

" Highlight git change signs
hi! SignifySignAdd guifg=#99c794
hi! SignifySignDelete guifg=#ec5f67
hi! SignifySignChange guifg=#c594c5
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
    \ }
