
" Keymap

" Open Vimrc in split
nnoremap <leader>ve :vsplit $MYVIMRC<CR>

" Source Vimrc
nnoremap <leader>vs :source $MYVIMRC<CR>

" Use jj as escape
inoremap jj <Esc>

" Yank to end of line
nnoremap Y y$

" Yank all matches
nnoremap <leader>Y :CopyMatches<CR>

" Update and go to previous file with backspace
nnoremap <BS> :update<CR><c-^>

" Open previous file in vertical split with shift backspace
nnoremap <leader><BS> :vsp<CR><c-^>

" Close and update buffer
nnoremap <leader>q ZZ<C-w><C-p>
nnoremap <leader>ll ZZ<C-w><C-p>

" Update current buffer and close it without saving (needed to close terminal buffers)
nnoremap <silent> <leader>dd :update<bar>:bd!<CR>

" Update and close buffer, keep window open and switch to previous file
nnoremap <silent> <leader>df :update<bar>:lclose<bar>b#<bar>bd! #<CR>

" Update current buffer and close all other buffer
nnoremap <silent> <leader>d<CR> :wa<bar>%bd!<bar>e#<bar>bd#<CR>

" Refresh buffer
nnoremap <leader>e :e<CR>

" Close all other wndows
nnoremap <leader><CR> :only<CR>

" Use dark theme
nnoremap <leader>td :colorscheme onedark<CR>

" Select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" Escape to clear highlighting in normal mode
nnoremap <silent> <esc> :nohlsearch<return><esc>
nnoremap <esc>^[ <esc>^[

" Toggle relative line numbers
nnoremap <silent> <leader>, :call NumberToggle()<cr>

" Tabs {{{
" New tab
nnoremap <leader>tn :tabnew<CR>
nnoremap <silent> [t :tabp<CR>      " Previous tab (override unimpaired jump to next tag)
nnoremap <silent> ]t :tabn<CR>      " Next tab (override unimpaired jump to previous tag)
" }}}

" Macros {{{
nnoremap <leader>mq :<C-U><C-R><C-R>='let @q = '. string(getreg('q'))<CR><C-F><left> " Easily edit the macro stored at register q
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>                              " Run macro over selected rows using @
" }}}

" Movement {{{
" Move to end of line
nnoremap L $
nnoremap L $
onoremap L $
" Move to start of line
nnoremap H ^
vnoremap H ^
onoremap H ^
" }}}

" Terminal {{{
nnoremap <silent> <Leader>tv :vs term://zsh<CR>  " Open zsh terminal in vertical or horizontal split
nnoremap <silent> <Leader>th :sp term://zsh<CR>
tnoremap <Esc> <C-\><C-n>                        " Escape to exit to normal mode in terminal
tnoremap jj <C-\><C-n>
" }}}

" Splits {{{
nnoremap <silent> <C-h> :call WinMove('h')<CR> " Move to the split in the direction shown, or create a new split
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>
nnoremap <C-w>f :vertical wincmd f<CR>         " Open file under cursor in vertical split
" }}}

" Folds {{{
" Navigate between closed folds
nnoremap <silent> zn :call NextClosedFold('j')<CR>
nnoremap <silent> zN :call NextClosedFold('k')<CR>
" }}}

" Grep / Search  {{{
" Regular grep
nnoremap <leader>h :silent grep! -R  .<left><left>
vnoremap <silent> / :<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
vnoremap <silent> ? :<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>

" Grep word under cursor: (from Learn Vimscript the hard way:
" http://learnvimscriptthehardway.stevelosh.com/chapters/32.html)
"nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cword>")) . " ."<CR>:copen<CR>
nnoremap <leader>g :call SearchAndGrep("normal")<CR>
vnoremap <leader>g :<c-u>call SearchAndGrep(visualmode())<CR>
" }}}

" Substitute {{{
nnoremap c* *``cgn
nnoremap c# *``cgN

nnoremap d* *``dgn
nnoremap d# *``dgN

nnoremap <C-space> :call SubstituteWordOrSelection("normal")<CR>
vnoremap <C-space> :<c-u>call SubstituteWordOrSelection(visualmode())<CR>

nnoremap <leader>s :cfdo %s///c \| update<left><left><left><left><left><left><left><left><left><left><left>
" }}}

" === Search shorcuts === "
"   <leader>/ - Clear highlighted search terms while preserving history
nmap <silent> <leader>/ :nohlsearch<CR>

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to
" Vim's default buffer
vnoremap <leader>p "_dP

" Leader s saves the file without closing
nmap <C-s> :w<CR>
