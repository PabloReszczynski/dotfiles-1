au BufWrite           * silent! mkview
au BufNewFile,BufRead * silent! loadview

syntax on

" Correct typos
ca WQ wq
ca wQ wq
ca Wq wq

ca QW wq
ca Qw wq
ca qW wq
ca qw wq

ca W w
ca Q q
" -------------

set fdm=marker
set foldmarker={{{,}}}

set number
set showmatch

set incsearch
set hlsearch

set autoindent
set cindent

set tabstop=3
set shiftwidth=3
set expandtab

set mouse=n

if has("autocmd")
  " When editing a file, always jump to the last known cursor position. 
  " Don't do it when the position is invalid or when inside an event handler 
  " (happens when dropping a file on gvim). 
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")

au BufNewFile *.sh      0r ~/.vim/skeltons/bash.skel
au BufNewFile *.php     0r ~/.vim/skeltons/php.skel
au BufNewFile *.pl      0r ~/.vim/skeltons/perl.skel
au BufNewFile main.cpp  0r ~/.vim/skeltons/main.cpp.skel
au BufNewFile main.c    0r ~/.vim/skeltons/main.c.skel

"> if "SLOW_SYSTEM" == 1
set noruler
set nocursorline
set scrolljump=10
"> else
set ruler
set cursorline
"> endif
