
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
" Icons
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Lua
Plug 'neovim/nvim-lspconfig'
Plug 'ojroques/nvim-lspfuzzy'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'lewis6991/gitsigns.nvim'
Plug 'akinsho/nvim-toggleterm.lua'
Plug 'folke/lsp-colors.nvim'
Plug 'folke/lsp-trouble.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/vim-vsnip'

" Syntax/Colors
Plug 'p00f/nvim-ts-rainbow'
Plug 'Yggdroot/indentLine'
Plug 'norcalli/nvim-base16.lua'

" Editing
Plug 'RRethy/vim-illuminate'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'matze/vim-move'
Plug 'windwp/nvim-ts-autotag'
Plug 'windwp/nvim-autopairs'
Plug 'simrat39/symbols-outline.nvim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'AndrewRadev/dsf.vim'
Plug 'dsznajder/vscode-es7-javascript-react-snippets', { 'do': 'yarn install --frozen-lockfile && yarn compile' }
Plug 'chaoren/vim-wordmotion'

Plug 'tweekmonster/startuptime.vim'

" === Initialize plugin system === "
call plug#end()

" Plugin settings

" Editing
nnoremap <leader>bs /<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>
vnoremap X "_d

" Indent Guides
" let g:indentLine_char = '┊'
let g:indentLine_char = '│'
let g:indentLine_first_char = '│'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0

" vim-better-whitespace
nmap <leader>y :StripWhitespace<CR>                              "   <leader>y - Automatically remove trailing whitespace

" vim-doge
nmap <leader>z :DogeGenerate<CR>

" Nvim Lua Tree
nnoremap <leader>n :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>f :NvimTreeFindFile<CR>
let g:nvim_tree_auto_close = 1
let g:nvim_tree_indent_markers = 1

" Vim Move
let g:move_map_keys = 0
vmap ∆ <Plug>MoveBlockDown
vmap ˚ <Plug>MoveBlockUp
nmap ∆ <Plug>MoveLineDown
nmap ˚ <Plug>MoveLineUp

" Git
nnoremap <leader>gc :GBranches<CR>
nnoremap <leader>ga :Git fetch --all<CR>
nnoremap <leader>grum :Git rebase upstream/master<CR>
nnoremap <leader>grom :Git rebase origin/master<CR>

lua require("init")

" Auto reload vimrc
augroup autoreloadvimrc
  autocmd!
  autocmd BufWritePost *.vim source $MYVIMRC
augroup end
" }}}

" Terminal buffer
augroup terminal
  autocmd!
  autocmd TermOpen *
    \ setlocal nonumber |
    \ setlocal signcolumn=no
augroup end
