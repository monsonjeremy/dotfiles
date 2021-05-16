
" let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
" if !filereadable(plugpath)
"     if executable('curl')
"         let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"         call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
"         if v:shell_error
"             echom "Error downloading vim-plug. Please install it manually.\n"
"             exit
"         endif
"     else
"         echom "vim-plug not installed. Please install it manually or install curl.\n"
"         exit
"     endif
" endif

" call plug#begin('~/.config/nvim/plugged')

" " FZF
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'

" " Icons
" Plug 'kyazdani42/nvim-web-devicons'
" Plug 'ryanoasis/vim-devicons'

" " Git
" Plug 'tpope/vim-fugitive'

" " Lua
" Plug 'neovim/nvim-lspconfig'
" Plug 'ojroques/nvim-lspfuzzy'
" Plug 'nvim-lua/lsp_extensions.nvim'
" Plug 'glepnir/lspsaga.nvim'
" Plug 'hrsh7th/nvim-compe'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
" Plug 'nvim-treesitter/nvim-treesitter-refactor'
" Plug 'akinsho/nvim-bufferline.lua'
" Plug 'lewis6991/gitsigns.nvim'
" Plug 'akinsho/nvim-toggleterm.lua'
" Plug 'folke/lsp-trouble.nvim'
" Plug 'kyazdani42/nvim-tree.lua'
" Plug 'norcalli/nvim-colorizer.lua'
" Plug 'onsails/lspkind-nvim'
" Plug 'hrsh7th/vim-vsnip'
" Plug 'famiu/nvim-reload'
" Plug 'folke/todo-comments.nvim'
" Plug 'sindrets/diffview.nvim'
" Plug 'hoob3rt/lualine.nvim'"
" Plug 'folke/which-key.nvim'
" Plug 'nanotee/zoxide.vim'

" " Syntax/Colors
" Plug 'p00f/nvim-ts-rainbow'
" Plug 'Yggdroot/indentLine'
" Plug 'folke/tokyonight.nvim'

" " Editing
" Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
" Plug 'matze/vim-move'
" Plug 'windwp/nvim-ts-autotag'
" Plug 'windwp/nvim-autopairs'
" Plug 'simrat39/symbols-outline.nvim'
" Plug 'b3nj5m1n/kommentary'
" Plug 'tpope/vim-surround'
" Plug 'tpope/vim-repeat'
" Plug 'AndrewRadev/dsf.vim'
" Plug 'dsznajder/vscode-es7-javascript-react-snippets', { 'do': 'yarn install --frozen-lockfile && yarn compile' }
" Plug 'chaoren/vim-wordmotion'

" Plug 'tweekmonster/startuptime.vim'

" " === Initialize plugin system === "
" call plug#end()




