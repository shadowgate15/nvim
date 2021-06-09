scriptencoding utf-8

"{{ Vim-plug related settings.
" The root directory to install all plugins.
let g:plug_home = expand(stdpath('data') . '/plugged')

" Use fastgit for clone on Linux systems.
if g:is_linux
  let g:plug_url_format = 'https://hub.fastgit.org/%s.git'
endif

augroup plug_init
  autocmd!
  autocmd VimEnter * PlugInstall --sync | quit |source $MYVIMRC
augroup END
"}}

call plug#begin()

" minimalist color scheme
Plug 'dikiaap/minimalist'


" Git command inside vim
Plug 'tpope/vim-fugitive'

" NERDTree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Highlight URLs inside vim
Plug 'itchyny/vim-highlighturl'

" For Windows and Mac, we can open an URL in the browser. For Linux, it may
" not be possible since we maybe in a server which disables GUI.
if g:is_win || g:is_mac
  " open URL in browser
  Plug 'tyru/open-browser.vim'
endif

" Automatic insertion and deletion of a pair of characters
Plug 'jiangmiao/auto-pairs'

" Autosave files on certain events
Plug '907th/vim-auto-save'

" Show git change (change, delete, add) signs in vim sign column
Plug 'mhinz/vim-signify'

" command-t
Plug 'wincent/command-t', {
    \   'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
    \ }

" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

"""""""""""""""""""""""""""vim-airline settings"""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'

" Skip empty sections if there are nothing to show,
" extracted from https://vi.stackexchange.com/a/9637/15292
let g:airline_skip_empty_sections = 1

" Tabline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Show buffer number for easier switching between buffer,
" see https://github.com/vim-airline/vim-airline/issues/1149
let g:airline#extensions#tabline#buffer_nr_show = 1

" Buffer number display format
let g:airline#extensions#tabline#buffer_nr_format = '%s. '

" Speed up airline
let g:airline_highlighting_cache = 1

" Disable scrollbar
let g:airline#extensions#scrollbar#enabled = 0

"""""""""""""""""""""""""vim-fugitive settings""""""""""""""""""""""""""""""
nnoremap <silent> <leader>gc :Git commit<CR>
nnoremap <silent> <leader>gs :Git<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gpl :Git pull<CR>
" Note that to use bar literally, we need backslash it, see also `:h :bar`.
nnoremap <silent> <leader>gpu :15split \| term git push

"""""""""""""""""""""""""vim-signify settings""""""""""""""""""""""""""""""
" The VCS to use
let g:signify_vcs_list = [ 'git' ]

" Change the sign for certain operations
let g:signify_sign_change = '~'

"""""""""""""""""""""""""""NERDTree settings""""""""""""""""""""""""""""""""
nnoremap <leader>n :NERDTreeFocus<CR>

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | wincmd p | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

""""""""""""""""""""""""""""open-browser.vim settings"""""""""""""""""""
if g:is_win || g:is_mac
  " Disable netrw's gx mapping.
  let g:netrw_nogx = 1

  " Use another mapping for the open URL method
  nmap ob <Plug>(openbrowser-smart-search)
  xmap ob <Plug>(openbrowser-smart-search)
endif

""""""""""""""""""""""""vim-auto-save settings"""""""""""""""""""""""
" Enable autosave on nvim startup
let g:auto_save = 1

" A list of events to trigger autosave
let g:auto_save_events = ['InsertLeave', 'TextChanged']

" Whether to show autosave status on command line
let g:auto_save_silent = 0
