call pathogen#infect()
call pathogen#helptags()
syntax on
filetype plugin indent on


" config from amix.dk
"

set history=700
filetype plugin on
filetype indent on

set autoread
set hidden
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Set working directory to current file
autocmd BufEnter * lcd %:p:h

""""""""""""""""""""""""""
" Vim user interface
" """"""""""""""""""""""""
set so=7
set wildmenu
set ruler
set cmdheight=2
set hid

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase
set smartcase

set hlsearch
set incsearch
set nolazyredraw

set magic
set showmatch
set mat=2

set gfn=Menlo:h12
set shell=/bin/bash

if has("gui_running")
	set guioptions-=T
	set t_Co=256
	set background=dark
	let g:zenburn_high_Contrast=1
	set nonu
    colors ir_black
    colorscheme ir_black
else
	colorscheme zellner
	set background=dark
	set nonu
endif

set encoding=utf8
try
	lang en_US
catch
endtry

set ffs=unix,dos,mac

"""""""""""""""""""""""""""""
" Back up stuff
" """""""""""""""""""""""""""

set nowb
set noswapfile

try
	set undodir=~/.vim/undodir

	set undofile
catch
endtry


set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set tw=500

set ai
set si
set wrap


""" Visual mode related
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> * :call VisualSearch('b')<CR>


" => Command mode stuff
cno $h e ~/

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close current buffer
map <leader>bd :Bclose<cr>
map <leader>ba :1,300 bd!<cr>

map <leader>cd :cd %:p:h<cr>

"""""""""""""""""""""""""""
" => Statusline
"""""""""""""""""""""""""""
set laststatus=2

if version >= 700
    au InsertEnter * hi Statusline term=reverse ctermbg=5 gui=undercurl guisp=Red
    au InsertLeave * hi Statusline term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
endif

" Format the Statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
    let curdir = substitute(getcwd(),'/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE '
    else
        return ''
    endif
endfunction

""""""""""""""""""""""""""""""""""""
" => Editing mappings
"

nmap <D-j> mz:m+<cr>`z
nmap <D-k> mz:m-2<cr>`z
vmap <D-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <D-k> :m'<-2<cr>`>my`<mzgv`yo`z

func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

set guitablabel=%t




""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def

" Run current program
au FileType python map <f9> :w<CR>:!python %<CR>


""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> AJS.log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return
au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction





""""""""""""""""""""""
" => Command-T
""""""""""""""""""""""
let g:CommandTMaxHeight = 15
set wildignore+=*.o,*.obj,.git,*.pyc

""""""""""""""""""""""
" => NERDTree
""""""""""""""""""""""
map <leader>f :NERDTreeToggle<cr>

let NERDTreeWinPos = 0
let NERDTreeWinSize = 31
let NERDTreeIgnore = ['\.vim$','\~$','\.png$','\.bmp$','\.jpg$','\.gif$','\.psd$','\.doc','\.ppt','\.xls','\.pdf$','\.exe$','\.lnk$','\.pyc$']
let NERDTreeMouseMode = 3

""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
map <leader>o :BufExplorer<cr>

"""""""""""""""""""""""""
" => Omni complete functions
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete


"""""""""""""""""""""""
" => AutoComplete Popup
"""""""""""""""""""""""
let g:acp_behaviorSnipmateLength = 1


"""""""""""""""""""""""""""
" => Tagbar
"""""""""""""""""""""""""""
let g:tagbar_usearrows = 1



nnoremap <leader>l :TagbarToggle<CR>


autocmd FileType html :setlocal sw=2 ts=2 sts=2
hi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
set cursorline
hi CursorLine cterm=NONE ctermbg=DarkGreen gui=NONE guibg=DarkGreen
set number

nmap <silent> <leader>/ :nohlsearch<CR>

nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

nmap <silent> <leader>ev :e $MYGVIMRC<cr>
nmap <silent> <leader>sv :so $MYGVIMRC<cr>
nmap <silent> <leader>z :ZoomWin<cr>

nmap <leader><leader>f :cd ~/FiveStars/github/fivestars/

nmap <silent> <leader>p :NERDTree fweb<cr>

nmap <leader><leader>ff :split ~/FiveStars/github/fivestars/loyalty
nmap <leader><leader>fs :split



if has("gui_macvim")
	macmenu &File.New\ Window key=<nop>
	macmenu &File.New\ Tab key=<D-n>
	map <D-t> :CommandT<CR>
endif
