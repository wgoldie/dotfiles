set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'sjl/gundo.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ggreer/the_silver_searcher'
Plugin 'scrooloose/nerdtree'
Plugin 'chriskempson/base16-vim'
Plugin 'losingkeys/vim-niji'
Plugin 'vim-scripts/paredit.vim'
Plugin 'jgdavey/tslime.vim'

call vundle#end()            " required

syntax on
filetype plugin indent on    " indent file based on type

set shiftwidth=4 tabstop=4 softtabstop=4 expandtab
set number
set showcmd     

colorscheme base16-eighties
set background=dark
set wildmenu " autocomplete menu in gutter
set lazyredraw " reduce visual noise and speed up macros
set showmatch " brace match anim

set incsearch " highlight while typing
set hlsearch " highlight matches

"disable search highlight with command
nnoremap <leader><Space> :nohlsearch<CR> 


"set foldenable
"set foldlevelstart=10
"set foldnestmax=10 
"nnoremap <space> za " command to toggle current block fold

"set foldmethod=indent   " fold based on indent level

let mapleader="," 

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" jk is escape
" inoremap jk <esc>

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" open ag.vim
nnoremap <leader>a :Ag

" custom settings by filenames
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
                \:call <SID>StripTrailingWhitespaces()
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd FileType lisp,scheme,art setlocal equalprg=scmindent.rkt
augroup END

" better swap/backup files
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" no help
nmap <F1> <nop>
nmap <Help> <nop>
" Command Make will call make and then cwindow which
" " opens a 3 line error window if any errors are found.
" " If no errors, it closes any open cwindow.
command -nargs=* Make make <args> | cwindow 3
set mouse=a

" tslime
vmap <C-c><C-c> <Plug>SendSelectionToTmux
nmap <C-c><C-c> <Plug>NormalModeSendToTmux
nmap <C-c>r <Plug>SetTmuxVars
let g:tslime_ensure_trailing_newlines = 1

