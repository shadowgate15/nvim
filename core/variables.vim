"{{ Custom variables
let g:is_win = has('win32') || has('win64')
let g:is_linux = has('unix') && !has('macunix')
let g:is_mac = has('macunix')
"}}

" Disable Python2 support
let g:loaded_python_provider = 0

" Disable perl provider
let g:loaded_perl_provider = 0

" set quit_filetypes
let g:quit_filetypes = ['qf', 'vista', 'nerdtree']

" Path to Python 3 interpreter (must be an absolute path), make startup
" faster. See https://neovim.io/doc/user/provider.html.
if executable('python')
   if g:is_win
    let g:python3_host_prog=substitute(exepath('python'), '.exe$', '', 'g')
  elseif g:is_linux || g:is_mac
    let g:python3_host_prog=exepath('python')
  endif
else
  echoerr 'Python 3 executable not found! You must install Python 3 and set its PATH correctly!'
endif

" set auto_insert_files
let g:auto_insert_files = ['COMMIT_EDITMSG']

" Custom mapping <leader> (see `:h mapleader` for more info)
noremap <space> <nop>
let mapleader = ' '
