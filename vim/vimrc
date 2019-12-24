" Stan Rokita's vimrc!
let mapleader=","

" Theme
colorscheme solarized
set background=dark

" quick exit of modes
inoremap <leader><leader> <esc>
vnoremap <leader><leader> <esc>

" for reloading vimscript
nnoremap <leader>ev :tabf<space>$MYVIMRC<cr>
nnoremap <leader>sv :source<space>$MYVIMRC<cr>

" work with tabs
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>tk :tabn<cr>
nnoremap <leader>tj :tabp<cr>

" copy paste stuff
set clipboard=unnamed
set backspace=2

" misc
set number
set ruler

syntax on
filetype plugin indent on

" indentation
" round indentations to mults of shift width
set shiftround

" width
set shiftwidth=4
set tabstop=4
set softtabstop=4

" spaces > tabs (also i use python the most so 4 spaces)
set expandtab

" new stuff i learned

" tenths of a second that previous matching paren will be highlighted
set matchtime=2
" activate the show prev paren feature
set showmatch

" put parentheses around white space seperated word
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lell

" put parenthese around curren visual selection
vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>l

" instead of hard to reach o and $ (these do overmap presets)
nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $

" forcing myself to not use these
inoremap <esc> <nop>
vnoremap <esc> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>
vnoremap <up> <nop>
vnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <bs> <nop>
vnoremap <bs> <nop>
nnoremap <del> <nop>

augroup python_stuff
    au!
    au FileType python onoremap <buffer> if :<c-u>execute "normal! ?^\\def.*$\r/^\\s*return.*$\r$"<cr>
    au FileType python iabbrev <buffer> tt True
    au FileType python iabbrev <buffer> ff False
augroup END
