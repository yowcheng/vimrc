set nocompatible               
filetype off                   

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'EasyMotion'
Bundle 'https://github.com/majutsushi/tagbar.git'
Bundle 'scrooloose/nerdtree'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'yuratomo/w3m.vim'
Bundle 'vim-scripts/grep.vim.git'
" Bundle 'https://bitbucket.org/ns9tks/vim-fuzzyfinder'
" Bundle 'http://git.wincent.com/command-t.git'

" filetype plugin indent on     " required! 

" General Settings

set tabstop=4
set shiftwidth=4
set expandtab
set nocompatible  " not compatible with the old-fashion vi mode
set bs=2		" allow backspacing over everything in insert mode
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set autoread		" auto read when file is changed from outside

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

syntax on		" syntax highlight
set hlsearch		" search highlighting

if has("gui_running")	" GUI color and font settings
  set guifont=Osaka-Mono:h20
  set background=dark 
  set t_Co=256          " 256 color mode
  set cursorline        " highlight current line
  colors moria
else
" terminal color settings
  colors vgod
endif

set incsearch           " incremental search
set ignorecase          " ignore case when searching

" status line {
set laststatus=2
set statusline=\ %{HasPaste()}%<%-25.25(%f%)%m%r%h\ %w\ \
set statusline+=\ \ \ [%{&ff}/%Y]
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "")
    return curdir
endfunction


function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction
" }


"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"---------------------------------------------------------------------------
" USEFUL SHORTCUTS
"---------------------------------------------------------------------------
"" set leader to ,
let mapleader=","
let g:mapleader=","

""NERDTree
let g:NERDTreeWinPos = "left"
"" Use <F4> to switch on/off NERDTree
nnoremap <silent> <F4> :NERDTreeToggle<CR>



"---------------------------------------------------------------------------
" cscope
"---------------------------------------------------------------------------
if has("cscope")
    let i = 1
    while i < 10
        if filereadable("cscope.out")
            let db = getcwd() . "/cscope.out"
            "echo db
            let $CSCOPE_DB = db
            cs add $CSCOPE_DB
            let i = 10
        else
            cd ..
            let i += 1
        endif
    endwhile
"elseif $CSCOPE_DB != ""
"    cs add $CSCOPE_DB

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" show msg when any other cscope db added
    set cscopeverbose 
set ttimeoutlen=100
endif


"---------------------------------------------------------------------------
" TagBar
"---------------------------------------------------------------------------
" toggle TagBar with F7
nnoremap <silent> <F7> :TagbarToggle<CR>
" set focus to TagBar when opening it
let g:tagbar_autofocus = 1
let g:tagbar_ctags_bin='ctags'

"---------------------------------------------------------------------------
"" Grep
"---------------------------------------------------------------------------
nnoremap <silent> <F3> :Grep<CR>
"---------------------------------------------------------------------------
"" Grep
"---------------------------------------------------------------------------
nnoremap <silent> <F3> :Grep<CR>
let Grep_Skip_Files = '*.tag *.out *.image *.o'
let Grep_Skip_Dirs = 'git'

" nmap <s-f9> :exec 'vimgrep /\<'.expand('<cword>').'\>/g **/*.[ch] **/*.[ch]pp **/*.java **/*.p[ly] **/*.rb'<CR>
