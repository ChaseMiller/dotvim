call pathogen#infect()
call pathogen#helptags()
syntax enable
filetype plugin indent on
" vim:fdm=marker

set nocompatible

set history=700
set autoread
set hidden
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>


" Vim user interface {{{
" Set working directory to current file
" autocmd BufEnter * lcd %:p:h
set number
set so=7
set wildmenu
set ruler
set cmdheight=2
set hid

set cc=100

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

colorscheme solarized
let g:solarized_termcolor=256
set background=light
set t_Co=256

set encoding=utf8
try
	lang en_US
catch
endtry

set ffs=unix,dos,mac
set guitablabel=%t
" }}}

" Back up {{{
set nowb
set noswapfile

try
	set undodir=~/.vim/undodir
	set undofile
catch
endtry
" }}}
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

" Buffer Stuff {{{
map <leader>bd :Bclose<cr>
map <leader>ba :1,300 bd!<cr>
map <leader>cd :cd %:p:h<cr>
" }}}
" Statusline {{{
set laststatus=2
" }}}
" Paste {{{
function! HasPaste()
    if &paste
        return 'PASTE MODE '
    else
        return ''
    endif
endfunction
" }}}
" Parenthesis/bracket expanding {{{
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i
" }}}
" Deleting Trailing White Spaces {{{
    func! DeleteTrailingWS()
        exe "normal mz"
        %s/\s\+$//ge
        exe "normal `z"
    endfunc
    autocmd BufWrite *.py :call DeleteTrailingWS()
" }}}

""" Language Related Stuff: """
" Python Section {{{
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
    " Python Mode Stuff
    let g:pymode_lint_ignore = ""
" }}}
" JavaScript section {{{
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
" }}}

""" Vim Bundle Plugins: """
    " Command-T {{{
        let g:CommandTMaxHeight = 15
        set wildignore+=*.o,*.obj,.git,*.pyc
        if has("gui_macvim")
            map <D-t> :CommandT<CR>
            map <D-r> :CommandTFlush<CR>
        endif
    " }}}
    " NERDTree {{{
        map <leader>f :NERDTreeToggle<cr>

        let NERDTreeWinPos = 0
        let NERDTreeWinSize = 31
        let NERDTreeIgnore = ['\.vim$','\~$','\.png$','\.bmp$','\.jpg$','\.gif$','\.psd$','\.doc','\.ppt','\.xls','\.pdf$','\.exe$','\.lnk$','\.pyc$']
        let NERDTreeMouseMode = 3
    " }}}
    " bufExplorer plugin {{{
        let g:bufExplorerDefaultHelp=0
        let g:bufExplorerShowRelativePath=1
        let g:bufExplorerSplitBelow=1
        let g:bufExplorerSplitRight=1
        map <leader>o :BufExplorer<cr>
    " }}}
    " Omni complete functions {{{
        autocmd FileType python set omnifunc=pythoncomplete#Complete
        autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
        autocmd FileType css set omnifunc=csscomplete#CompleteCSS
        autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
        autocmd FileType php set omnifunc=phpcomplete#CompletePHP
        autocmd FileType c set omnifunc=ccomplete#Complete
    " }}}
    " AutoComplete Popup {{{
        let g:acp_behaviorSnipmateLength = 1
    " }}}
    " Tagbar {{{
        let g:tagbar_usearrows = 1
        nnoremap <leader>l :TagbarToggle<CR>
    " }}}
    " VIm grep {{{
        let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
        set grepprg=/usr/bin/grep\ -nH
    " }}}
    " SnipMate {{{
        :autocmd FileType python set ft=python.django
        :autocmd FileType html set ft=html.djangohtml
        :autocmd FileType soy set ft=html
    " }}}
    " Surround {{{
        let g:surround_{char2nr("b")} = "{% block\1 \r..*\r &\1%}\r{% endblock %}"
        let g:surround_{char2nr("i")} = "{% if\1 \r..*\r &\1%}\r{% endif %}"
        let g:surround_{char2nr("w")} = "{% with\1 \r..*\r &\1%}\r{% endwith %}"
        let g:surround_{char2nr("c")} = "{% comment\1 \r..*\r &\1%}\r{% endcomment %}"
        let g:surround_{char2nr("f")} = "{% for\1 \r..*\r &\1%}\r{% endfor %}"
        let g:surround_{char2nr("v")} = "{{ \1 \r..*\r &\1\r }}"
    " }}}
    " Project {{{
        nmap <silent> <leader>p :Project<cr>
    " }}}
    " Vimwiki {{{
        nmap <silent><Leader>w :VimwikiIndex<cr>
    " }}}
    " Powerline {{{
        "set Powerline_cache_enabled = 1
        "set g:Powerline_symbols = unicode
        "set Powerline_symbols = 'Menlo'
        let g:Powerline_cache_enabled = 1
        let g:Powerline_symobls = 'fancy'
    " }}}
    " Ack {{{
        nmap <D-l> :Ack 
    " }}}
    " Vimroom {{{
        let g:vimroom_guibackground = "#fdf6e3"
        let g:vimroom_width = 100
        let g:vimroom_sidebar_height = 1
        nnoremap <silent><Leader>v :VimroomToggle<CR>
    " }}}
    " Tabman {{{
        map <silent><leader>t :TMToggle<CR>
        "let g:tabman_toggle = '<leader>mt'
        "let g:tabman_focus  = '<leader>mf'
        let g:tabman_width = 25
        let g:tabman_side = 'left'
    " }}}
    " ZoomWin {{{
    nmap <silent> <leader>z :ZoomWin<cr>
    " }}}

""" Random Stuff: """
" Substitute word under cursor/selection {{{
nnoremap <C-s> :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
" }}}
" Chrome reload {{{
function! ChromeReload()
python << EOF
    from subprocess import call
    browser = """
    tell application "Google Chrome" to tell the active tab of its first window
        reload
    end tell
    tell application "Google Chrome" to activate
    """
    call(['osascript', '-e', browser])
EOF
endfunction 
map <leader>r :call ChromeReload()<CR>
" }}}
" tab space stuff {{{
set expandtab
set smarttab
set tabstop=4 shiftwidth=4
" }}}
" tab controls {{{
if has("gui_macvim")
    " emulate textmate's shift left/right key commands
    nmap <D-[> <<
    nmap <D-]> >>
    vmap <D-[> <gv
    vmap <D-]> >gv
endif
" }}}
" Move line up or down (visual mode too) {{{
if has("gui_macvim")
    nmap <D-j> mz:m+<cr>`z
    nmap <D-k> mz:m-2<cr>`z
    vmap <D-j> :m'>+<cr>`<my`>mzgv`yo`z
    vmap <D-k> :m'<-2<cr>`>my`<mzgv`yo`z
endif
" }}}
" Remapping of CMD {{{
if has("gui_macvim")
    inoremap <D-CR> 
endif
" }}}
" switch osx windows with swipes {{{
if has("gui_macvim")
    nnoremap <silent> <SwipeLeft> :macaction _cycleWindowsBackwards:<CR>
    nnoremap <silent> <SwipeRIght> :macaction _cycleWindows:<CR>
endif
" }}}
" Fivestars stuff {{{
nmap <leader><leader>f :cd ~/FiveStars/github/server/loyalty<cr>
"nmap <leader><leader>cd :cd ~/FiveStars/github/server/
" }}}

nmap <silent> <leader>/ :nohlsearch<CR>

nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

nmap <silent> <leader>ev :e $MYGVIMRC<cr>
nmap <silent> <leader>sv :so $MYGVIMRC<cr>

nmap <leader>bs :BufExplorerHorizontalSplit<CR>
nmap <leader>bv :BufExplorerVerticalSplit<CR>

if has("gui_macvim")
	macmenu &File.New\ Window key=<nop>
	macmenu &File.New\ Tab key=<D-n>
endif

" navigate splits with command [ and ]
" map <D-;> <C-w>h
" map <D-'> <C-w>l

nmap <silent><leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>
" maps enter to insert a new-line and shift enter to insert a line before the current line {{{
map <S-Enter> O<Esc>
map <CR> o<Esc>
" }}}
