scriptencoding utf-8

"{{ Vim-plug related settings.
" The root directory to install all plugins.
let g:plug_home = expand(stdpath('data') . '/plugged')

" Use fastgit for clone on Linux systems.
if g:is_linux
  let g:plug_url_format = 'https://hub.fastgit.org/%s.git'
endif

" disable ALE lsp
let g:ale_disable_lsp = 1

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

" command-t
Plug 'wincent/command-t', {
    \   'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
    \ }

" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Additional powerful text object for vim, this plugin should be studied
" carefully to use its full power
Plug 'wellle/targets.vim'

" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ALE
Plug 'dense-analysis/ale'

" Asynchronous command execution
Plug 'skywind3000/asyncrun.vim'

" EasyMotion
Plug 'easymotion/vim-easymotion'

" Livedown
Plug 'shime/vim-livedown'

" syntax helpers
Plug 'digitaltoad/vim-pug'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'elzr/vim-json'

" tmuxline.vim
Plug 'edkolev/tmuxline.vim'

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

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

"""""""""""""""""""""""""vim-fugitive settings""""""""""""""""""""""""""""""
nnoremap <silent> <leader>gc :Git commit<CR>
nnoremap <silent> <leader>gs :Git<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gpl :Git pull<CR>
" Note that to use bar literally, we need backslash it, see also `:h :bar`.
nnoremap <silent> <leader>gpu :15split \| term git push<CR>

"""""""""""""""""""""""""""NERDTree settings""""""""""""""""""""""""""""""""
nnoremap <leader>n :NERDTreeFocus<CR>

" change CWD when root tree is changed
let NERDTreeChDirMode = 2

" open Bookmarks by default
let NERDTreeShowBookmarks = 1

augroup nerdtree_start
  " Start NERDTree when Vim is started without file arguments.
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
augroup END

augroup nerdtree_no_replace
  " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
  autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
      \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
augroup END

augroup nerdtree_mirror
  " Open the existing NERDTree on each new tab.
  autocmd BufWinEnter * silent NERDTreeMirror
augroup END

""""""""""""""""""""""""""""open-browser.vim settings"""""""""""""""""""
if g:is_win || g:is_mac
  " Disable netrw's gx mapping.
  let g:netrw_nogx = 1

  " Use another mapping for the open URL method
  nmap <leader>ob <Plug>(openbrowser-smart-search)
  xmap <leader>ob <Plug>(openbrowser-smart-search)
endif

""""""""""""""""""""""""vim-auto-save settings"""""""""""""""""""""""
" Enable autosave on nvim startup
let g:auto_save = 1

" A list of events to trigger autosave
let g:auto_save_events = ['InsertLeave', 'TextChanged']

" Whether to show autosave status on command line
let g:auto_save_silent = 0

"""""""""""""""""""""""""""coc.nvim settings"""""""""""""""""""""""""""""
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

augroup coc_highlight_hold
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
nmap <leader>f :Format<cr>

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"""""""""""""""""""""""""""command-t settings"""""""""""""""""""""""""""""
let g:CommandTCancelMap = '<Esc>'

let g:CommandTWildIgnore=&wildignore . ',*/.git,*/build,*/node_modules'

""""""""""""""""""""""""""asyncrun.vim settings""""""""""""""""""""""""""
" Automatically open quickfix window of 6 line tall after asyncrun starts
let g:asyncrun_open = 6

let g:asyncrun_status = 'stopped'
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

nnoremap <leader>r :AsyncRun<space>

""""""""""""""""""""""""""ALE settings""""""""""""""""""""""""""
" linters for different filetypes
let g:ale_linters = {
  \ 'vim': ['vint'],
  \ }

" ale fixers
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'typescript': ['eslint', 'prettier'],
  \ 'javascript': ['prettier', 'xo'],
  \ 'html': ['prettier'],
  \ 'css': ['prettier'],
  \ 'json': ['prettier']
  \ }

" fix on save
let g:ale_fix_on_save = 1

" change message to include which linter
let g:ale_echo_msg_format = '[%linter%]%code: %%s'

""""""""""""""""""""""""""EasyMotion settings""""""""""""""""""""""""""

" thx to @dsibiski
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
