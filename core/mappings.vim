" fast saving
nnoremap <leader>w :up<cr>

" close buffer
nnoremap <leader>q :q<cr>
" close all buffers
nnoremap <leader>Q :qa<cr>

" fast window switching
map <leader><leader> <C-W>w

" fast escaping
imap jj <ESC>

" ignore lines when going up or down
nnoremap j gj
nnoremap k gk

" Yank from current cursor position to the end of the line (make it
" consistent with the behavior of D, C)
nnoremap Y y$

" Continuous visual shifting (does not exit Visual mode), `gv` means
" to reselect previous visual area, see https://superuser.com/q/310417/736190
xnoremap < <gv
xnoremap > >gv

" Edit and reload init.vim quickly
nnoremap <silent> <leader>ev :<C-U>tabnew $MYVIMRC <bar> tcd %:h<cr>
nnoremap <silent> <leader>sv :<C-U>silent update $MYVIMRC <bar> source $MYVIMRC <bar>
      \ echomsg "Nvim config successfully reloaded!"<cr>

" Decrease indent level in insert mode with shift+tab
inoremap <S-Tab> <ESC><<i

nnoremap <silent> gb :<C-U>call buf_utils#GoToBuffer(v:count, 'forward')<CR>
nnoremap <silent> gB :<C-U>call buf_utils#GoToBuffer(v:count, 'backward')<CR>

" terminal fast escaping
tnoremap jj <C-\><C-N>
