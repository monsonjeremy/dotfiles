
" Keymap

" Console log whats currently in the clipboard
let @l = "iconsole.log('jjpa:', jjpA;jj=="

nnoremap <Space> <Nop>

" Open Vimrc in split
nnoremap <leader>ve :vsplit $MYVIMRC<CR>

" Source Vimrc
nnoremap <Leader>vs :so ~/.config/nvim/init.vim<CR>

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

" Update and close buffer, keep window open and switch to previous file
nnoremap <silent> <leader>ds :update<bar>:lclose<bar>b#<bar>bd! #<CR>

" Update current buffer and close all other buffer
nnoremap <silent> <leader>d<CR> :wa<bar>%bd!<bar>e#<bar>bd#<CR>

" Refresh buffer
nnoremap <leader>e :e<CR>

" Close all other wndows
nnoremap <leader><CR> :only<CR>

" Select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" Escape to clear highlighting in normal mode
nnoremap <silent> <esc> :nohlsearch<return><esc>
nnoremap <esc>^[ <esc>^[

" Toggle relative line numbers
nnoremap <silent> <leader>, :call NumberToggle()<cr>

" Macros
nnoremap <leader>mq :<C-U><C-R><C-R>='let @q = '. string(getreg('q'))<CR><C-F><left> " Easily edit the macro stored at register q
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>                              " Run macro over selected rows using @

" Movement
" Move to end of line
nnoremap L $
nnoremap L $
onoremap L $
" Move to start of line
nnoremap H ^
vnoremap H ^
onoremap H ^


" Terminal
nnoremap <silent> <Leader>tv :vs term://zsh<CR>  " Open zsh terminal in vertical or horizontal split
nnoremap <silent> <Leader>th :sp term://zsh<CR>
tnoremap <Esc> <C-\><C-n>                        " Escape to exit to normal mode in terminal
tnoremap jj <C-\><C-n>

" Grep / Search
vnoremap <silent> / :<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
vnoremap <silent> ? :<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>

" Substitute
nnoremap c* *``cgn
nnoremap c# *``cgN

nnoremap d* *``dgn
nnoremap d# *``dgN

nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to
" Vim's default buffer
" greatest remap ever
vnoremap <leader>p "_dP

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <leader>d "_d
vnoremap <leader>d "_d

nnoremap <Leader>ww oconst wait = (ms: number): Promise<void> => {<CR>return new Promise(res => setTimeout(res, ms));<CR>}<esc>k=i{<CR>

