" ============================================================================ "
" ===                               PLUGINS                                === "
" ============================================================================ "

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

" === Editing Plugins === "

" Trailing whitespace highlighting & automatic fixing
Plug 'ntpeters/vim-better-whitespace'

" code commenting
Plug 'tpope/vim-commentary'

" auto-close plugin
Plug 'jiangmiao/auto-pairs'

" Snippet support
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" auto-close tags
Plug 'alvan/vim-closetag'

" Surround plugin
Plug 'tpope/vim-surround'

" Repeat Plugin
Plug 'tpope/vim-repeat'

" Intellisense Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Print function signatures in echo area
Plug 'Shougo/echodoc.vim'

" === Git Plugins === "
" Enable git changes to be shown in sign column
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" === Syntax Highlighting === "
Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'

" Generate JSDoc commands based on function signature
Plug 'heavenshell/vim-jsdoc'

" === UI === "

" File explorer
Plug 'scrooloose/nerdtree'

" Denite - Fuzzy finding, buffer management
Plug 'Shougo/denite.nvim'

" Colorscheme
Plug 'joshdick/onedark.vim'

" Customized vim status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Initialize plugin system
call plug#end()
